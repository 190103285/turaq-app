//
//  HelpViewController.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 24.04.2023.
//

import UIKit

protocol HelpDisplayLogic: AnyObject {
    func displayHelp(_ viewModel: HelpModels.Initital.ViewModel)
}

final class HelpViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var interactor: HelpBusinessLogic?
    var router: (HelpRoutingLogic & HelpDataPassing)?
    
    // MARK: - Private Properties
    
    private lazy var contentView: HelpViewLogic = {
        let view = HelpView()
        view.delegate = self
        view.tableView.delegate = self
        view.tableView.dataSource = self
        
        return view
    }()
    
    private var sections: [HelpModels.SectionType] = []
    
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
    
    // MARK: - Private Methods
    
    private func configure() {
        interactor?.getHelp()
    }
}

// MARK: - UITableViewDataSource

extension HelpViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .info(types: let types):
            return types.count
        case .chat:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .info(types: let types):
            let cell = HelpViewCell.reusable(for: tableView, indexPath: indexPath)
            cell.bind(with: types[indexPath.row].rawValue)
            cell.separatorView.isHidden = indexPath.row == types.count - 1
            
            return cell
        case .chat(title: let title):
            let cell = MenuHelpViewCell.reusable(for: tableView, indexPath: indexPath)
            cell.setTitle(title)
            
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

extension HelpViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch sections[indexPath.section] {
        case .info(types: let types):
            switch types[indexPath.row] {
            case .faq:
                router?.routeToFaq()
            case .licenseAgreement:
                router?.routeToLicenseAgreement()
            case .privacyPolicy:
                router?.routeToPrivacyPolicy()
            }
        case .chat(title: _):
            router?.routeToChat()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch sections[section] {
        case .info:
            return 0
        case .chat:
            return 32
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch sections[section] {
        case .chat:
            return HelpViewFooterView()
        case .info:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch sections[section] {
        case .info:
            return 0
        case .chat:
            return 32
        }
    }
}

// MARK: - Display Logic

extension HelpViewController: HelpDisplayLogic {
    
    func displayHelp(_ viewModel: HelpModels.Initital.ViewModel) {
        self.sections = viewModel.sections
        contentView.reload()
    }
}

extension HelpViewController: HelpViewDelegate {
    
    func helpViewBackButtonDidTap(_ view: HelpView) {
        dismiss(animated: true)
    }
}
