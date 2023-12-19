//  Created by Akyl on 01.03.2023.

import UIKit
import CoreLocation

protocol ProfileDisplayLogic: AnyObject {
    func presentProfile(_ viewModel: ProfileModels.Initial.ViewModel)
    func logouted()
    func accountDeleted()
}

final class ProfileViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var interactor: ProfileBusinessLogic?
    var router: (ProfileRoutingLogic & ProfileDataPassing)?
    
    // MARK: - Private Properties
    
    private lazy var contentView: ProfileViewLogic = {
        let view = ProfileView()
        view.delegate = self
        view.tableView.delegate = self
        view.tableView.dataSource = self
        view.tableView.refreshControl?.addTarget(self, action: #selector(didRefreshControl), for: .valueChanged)
        
        return view
    }()
    
    private var sections: [ProfileModels.Initial.ViewModel.SectionType] = []
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    @objc
    private func didRefreshControl() {
        PermissionsManager.isNotificationPermissionEnabled { [weak self] isEnabled in
            self?.interactor?.loadProfile(isEnabled)
        }
        contentView.stopLoading()
    }
}

// MARK: - Private Methods

private extension ProfileViewController {
    
    func configure() {
        contentView.startSkeletonLoading()
        PermissionsManager.isNotificationPermissionEnabled { [weak self] isEnabled in
            self?.interactor?.loadProfile(isEnabled)
        }
    }
    
    func showLogoutAlert() { // TODO: Localization
        showAlert(
            title: "Attention".localized(),
            message: "Вы действительно хотите выйти с аккаунта?",
            image: nil,
            actions: AlertAction(title: "Continue".localized(), style: .main) { [weak self] _ in
                self?.interactor?.logout()
            },
            AlertAction(title: "Cancel".localized(), style: .default)
        )
    }
    
    func showDeleteAccountAlert(_ id: Int) {
        showAlert(
            title: "Attention".localized(),
            message: "Вы уверены, что хотите безвозвратно удалить аккаунт?",
            image: nil,
            actions: AlertAction(title: "Продолжить", style: .main) { [weak self] _ in
                self?.interactor?.deleteAccount(with: id)
            },
            AlertAction(title: "Cancel".localized(), style: .default)
        )
    }
}

// MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch sections[indexPath.section] {
        case .profileData(title: _, models: _):
            return
        case .settings(title: _, models: let models):
            if models[indexPath.row].settingsType == .language {
                router?.routeToSettings()
            }
        case .deleteAccount(model: let model):
            showDeleteAccountAlert(model.userId)
        case .logout(model: _):
            showLogoutAlert()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch sections[section] {
        case .profileData(title: let title, models: _), .settings(title: let title, models: _):
            let view = ProfileHeaderView()
            view.bind(with: title)
            
            return view
        default:
            return nil
        }
    }
}

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .profileData(title: _, models: let models):
            return models.count
        case .settings(title: _, models: let models):
            return models.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .profileData(title: _, models: let models):
            let cell = ProfileViewDataCell.reusable(for: tableView, indexPath: indexPath)
            cell.bind(with: models[indexPath.row])
            cell.selectionStyle = .none
            
            return cell
        case .settings(title: _, models: let models):
            let cell = ProfileViewSettingsCell.reusable(for: tableView, indexPath: indexPath)
            cell.bind(with: models[indexPath.row])
            cell.delegate = self
            
            return cell
        case .deleteAccount(model: let model):
            let cell = ProfileViewDeleteAccountCell.reusable(for: tableView, indexPath: indexPath)
            cell.bind(with: model)
            
            return cell
        case .logout(model: let model):
            let cell = ProfileViewLogoutCell.reusable(for: tableView, indexPath: indexPath)
            cell.bind(with: model)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch sections[section] {
        case .profileData:
            return 16
        case .settings:
            return 48
        default:
            return 0
        }
    }
}

// MARK: - Display Logic

extension ProfileViewController: ProfileDisplayLogic {
    
    func presentProfile(_ viewModel: ProfileModels.Initial.ViewModel) {
        self.sections = viewModel.sections
        contentView.reload()
        contentView.stopSkeletonLoading()
    }
    
    func logouted() {
        router?.routeToAuth()
    }
    
    func accountDeleted() {
        router?.routeToAuth()
    }
}

// MARK: - ProfileViewSettingsCellDelegate

extension ProfileViewController: ProfileViewSettingsCellDelegate {
    
    func profileViewSettingsCell(_ cell: ProfileViewSettingsCell, switchValueDidChange isOn: Bool, type: ProfileModels.SettingsCell.SettingsType) {
        switch type {
        case .location, .push:
            router?.routeToSettings()
        case .language:
            return
        }
    }
}

// MARK: - ProfileViewDelegate

extension ProfileViewController: ProfileViewDelegate {
    
    func profileViewBackButtonDidTap(_ view: ProfileView) {
        dismiss(animated: true)
    }
}

// MARK: - CLLocationManagerDelegate

extension ProfileViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            return
        case .denied, .restricted:
            return
        default:
            break
        }
    }
}
