//
//  MenuViewController.swift
//  TuraqApp
//
//  Created by Akyl on 12.03.2023.
//

import UIKit
import SkeletonView

protocol MenuDisplayLogic: AnyObject {
    func displayMenu(_ viewModel: MenuModels.Initial.ViewModel)
}

final class MenuViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var interactor: MenuBusinessLogic?
    var router: (MenuRoutingLogic & MenuDataPassing)?
    
    // MARK: - Private Properties
    
    private lazy var contentView: MenuViewLogic = {
        let view = MenuView()
        view.tableView.dataSource = self
        view.tableView.delegate = self
        
        return view
    }()
    
    private var sections: [MenuModels.Initial.ViewModel.SectionType] = []
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        interactor?.loadMenu()
        contentView.startSkeletonLoading()
    }
}

extension MenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        switch sections[indexPath.section] {
        case .profile(phoneNumber: _):
            router?.routeToProfile()
        case .mys:
            return
        case .help:
            router?.routeToHelp()
        case .history:
            router?.routeToHistory()
        }
    }
}

// MARK: - UITableViewDataSource

extension MenuViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .profile(phoneNumber: let phoneNumber):
            let cell = MenuProfileViewCell.reusable(for: tableView, indexPath: indexPath)
            cell.bind(with: phoneNumber)
            
            return cell
        case .mys(carModel: let carModel, cardModel: let cardModel):
            let cell = MenuMysViewCell.reusable(for: tableView, indexPath: indexPath)
            cell.delegate = self
            cell.selectionStyle = .none
            cell.bind(carModel: carModel, cardModel: cardModel)

            return cell
        case .help:
            let cell = MenuHelpViewCell.reusable(for: tableView, indexPath: indexPath)
            
            return cell
        case .history:
            let cell = MenuHistoryViewCell.reusable(for: tableView, indexPath: indexPath)
            
            return cell
        }
    }
}

// MARK: - MenuMysViewCellDelegate

extension MenuViewController: MenuMysViewCellDelegate {
    
    func didTapMyCars() {
        router?.routeToMyCars()
    }
    
    func didTapMyCards() {
        router?.routeToMyCards()
    }
}

// MARK: - Display Logic

extension MenuViewController: MenuDisplayLogic {
    
    func displayMenu(_ viewModel: MenuModels.Initial.ViewModel) {
        self.sections = viewModel.sections
        contentView.reload()
        contentView.stopSkeletonLoading()
    }
}
