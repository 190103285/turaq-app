//
//  MyCardsViewController.swift
//  TuraqApp
//
//  Created by Akyl on 07.03.2023.
//

import UIKit

protocol MyCardsDisplayLogic: AnyObject {
    func displayMyCards(_ viewModel: MyCardsFlow.Initital.ViewModel)
}

final class MyCardsViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var interactor: MyCardsBusinessLogic?
    var router: (MyCardsRoutingLogic & MyCardsDataPassing)?
    
    // MARK: - Private Properties
    
    private lazy var contentView: MyCardsViewLogic = {
        let view = MyCardsView()
        view.delegate = self
        view.tableView.delegate = self
        view.tableView.dataSource = self
        view.tableView.refreshControl?.addTarget(self, action: #selector(didRefreshControl), for: .valueChanged)
        
        return view
    }()
    
    private var sections: [MyCardsFlow.Initital.SectionType] = []
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configure()
    }
    
    @objc
    private func didRefreshControl() {
        interactor?.loadMyCards()
        contentView.stopLoading()
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        interactor?.loadMyCards()
        navigationController?.isNavigationBarHidden = true
    }
}

extension MyCardsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch sections[section] {
        case .cards(title: let title, models: _):
            let view = ProfileHeaderView()
            view.bind(with: title)

            return view
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch sections[indexPath.section] {
        case .cards(title: _, models: let models):
            tableView.visibleCells.forEach { $0.isSelected = false }
            let cell = tableView.cellForRow(at: indexPath)
            cell?.isSelected = true
            interactor?.setCard(with: models[indexPath.row].id)
        case .addNew:
            tableView.deselectRow(at: indexPath, animated: false)
            router?.routeToAddCard()
        }
    }
}

extension MyCardsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .cards(title: _, models: let models):
            return models.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .cards(title: _, models: let models):
            let cell = MyCardsViewCell.reusable(for: tableView, indexPath: indexPath)
            cell.bind(with: models[indexPath.row])
            cell.isSelected = models[indexPath.row].isSelected
            cell.separatorView.isHidden = indexPath.row == models.count - 1
            
            return cell
        case .addNew:
            let cell = AddCardViewCell.reusable(for: tableView, indexPath: indexPath)
            
            return cell
        }
    }
}

// MARK: - Display Logic

extension MyCardsViewController: MyCardsDisplayLogic {
    
    func displayMyCards(_ viewModel: MyCardsFlow.Initital.ViewModel) {
        self.sections = viewModel.sections
        contentView.reload()
    }
}

extension MyCardsViewController: MyCardsViewDelegate {
    
    func myCardsViewBackButtonDidTap(_ view: MyCardsView) {
        self.dismiss(animated: true)
    }
}
