//
//  MyCarsViewController.swift
//  TuraqApp
//
//  Created by Akyl on 05.03.2023.
//

import UIKit

protocol MyCarsDisplayLogic: AnyObject {
    func displayMyCars(_ viewModel: MyCarsFlow.Initital.ViewModel)
}

final class MyCarsViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var interactor: MyCarsBusinessLogic?
    var router: (MyCarsRoutingLogic & MyCarsDataPassing)?
    
    // MARK: - Private Properties
    
    private lazy var contentView: MyCarsViewLogic = {
        let view = MyCarsView()
        view.delegate = self
        view.tableView.delegate = self
        view.tableView.dataSource = self
        view.tableView.refreshControl?.addTarget(self, action: #selector(didRefreshControl), for: .valueChanged)
        
        return view
    }()
    
    private var sections: [MyCarsFlow.Initital.SectionType] = []
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configure()
    }
    
    @objc
    private func didRefreshControl() {
        interactor?.loadMyCars()
        contentView.stopLoading()
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        interactor?.loadMyCars()
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - UI Actions
}

extension MyCarsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch sections[section] {
        case .cars(title: let title, models: _):
            let view = ProfileHeaderView()
            view.bind(with: title)
            
            return view
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch sections[indexPath.section] {
        case .cars(title: _, models: let models):
            tableView.visibleCells.forEach { $0.isSelected = false }
            let cell = tableView.cellForRow(at: indexPath)
            cell?.isSelected = true
            interactor?.setCar(with: models[indexPath.row].id)
        case .addNew:
            tableView.deselectRow(at: indexPath, animated: false)
            router?.routeToAddCar()
        }
    }
}

extension MyCarsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .cars(title: _, models: let models):
            return models.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .cars(title: _, models: let models):
            let cell = MyCarsViewCell.reusable(for: tableView, indexPath: indexPath)
            cell.bind(with: models[indexPath.row])
            cell.isSelected = models[indexPath.row].isSelected
            cell.separatorView.isHidden = indexPath.row == models.count - 1
            
            return cell
        case .addNew:
            let cell = AddCarViewCell.reusable(for: tableView, indexPath: indexPath)
            
            return cell
        }
    }
}

// MARK: - Display Logic

extension MyCarsViewController: MyCarsDisplayLogic {
    
    func displayMyCars(_ viewModel: MyCarsFlow.Initital.ViewModel) {
        self.sections = viewModel.sections
        contentView.reload()
    }
}

extension MyCarsViewController: MyCarsViewDelegate {
    
    func myCarsViewBackButtonDidTap(_ view: MyCarsView) {
        self.dismiss(animated: true)
    }
}
