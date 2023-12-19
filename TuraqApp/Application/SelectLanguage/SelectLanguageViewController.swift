////
////  SelectLanguageViewController.swift
////  TuraqApp
////
////  Created by Akyl Temirgaliyev on 26.04.2023.
////
//
//import UIKit
//
//final class SelectLanguageViewController: UIViewController {
//    
//    // MARK: - Public Properties
//    
//    var interactor: MyCardsBusinessLogic?
//    var router: (MyCardsRoutingLogic & MyCardsDataPassing)?
//    
//    private lazy var contentView: MyCardsViewLogic = {
//        let view = MyCardsView()
//        view.tableView.delegate = self
//        view.tableView.dataSource = self
//        view.tableView.refreshControl?.addTarget(self, action: #selector(didRefreshControl), for: .valueChanged)
//        
//        return view
//    }()
//    
//    var sections: [MyCardsFlow.Initital.SectionType] = []
//    
//    // MARK: - Private Properties
//    
//    
//    // MARK: - Lifecycle
//    
//    override func loadView() {
//        view = contentView
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configure()
//        interactor?.loadMyCards()
//        if let navController = self.navigationController as? BaseNavigationController {
//            navController.closingDelegate = self
//        }
//    }
//    
//    @objc
//    private func didRefreshControl() {
//        interactor?.loadMyCards()
//        contentView.stopLoading()
//    }
//    
//    // MARK: - Public Methods
//    
//    //
//    
//    // MARK: - Requests
//    
//    //
//    
//    // MARK: - Private Methods
//    
//    private func configure() {
//        
//    }
//    
//    // MARK: - UI Actions
//    
//    //
//}
//
//extension SelectLanguageViewController: UITableViewDelegate {
//    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        switch sections[section] {
//        case .cards(title: let title, models: _):
//            let view = ProfileHeaderView()
//            view.bind(with: title)
//
//            return view
//        default:
//            return nil
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        switch sections[indexPath.section] {
//        case .cards(title: _, models: let models):
//            tableView.visibleCells.forEach { $0.isSelected = false }
//            let cell = tableView.cellForRow(at: indexPath)
//            cell?.isSelected = true
//            interactor?.setCard(with: models[indexPath.row].id)
//        case .addNew:
//            tableView.deselectRow(at: indexPath, animated: false)
//            router?.routeToAddCard()
//        }
//    }
//}
//
//extension SelectLanguageViewController: UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        3
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let cell = MyCardsViewCell.reusable(for: tableView, indexPath: indexPath)
//            cell.bind(with: models[indexPath.row])
//            cell.isSelected = models[indexPath.row].isSelected
//            cell.separatorView.isHidden = indexPath.row == models.count - 1
//            
//            return cell
//    }
//}
//
//// MARK: - Display Logic
//
////extension MyCardsViewController: MyCardsDisplayLogic {
////
////    func displayMyCards(_ viewModel: MyCardsFlow.Initital.ViewModel) {
////        self.sections = viewModel.sections
////        contentView.reload()
////    }
////}
////
////extension MyCardsViewController: BaseNavigationControllerDelegate {
////
////    func coordinatorNavigationControllerDidBack(_ navigationController: BaseNavigationController) {
////        self.dismiss(animated: true)
////    }
////}
//
