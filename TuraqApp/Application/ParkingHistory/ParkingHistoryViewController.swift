//  Created by Akyl Temirgaliyev on 10.04.2023.

import UIKit

protocol ParkingHistoryDisplayLogic: AnyObject {
    func displayHistory(_ viewModel: [ParkingHistoryModels.Something.Section])
}

final class ParkingHistoryViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var interactor: ParkingHistoryBusinessLogic?
    var router: (ParkingHistoryRoutingLogic & ParkingHistoryDataPassing)?
    
    // MARK: - Private Properties
    
    private lazy var contentView: ParkingHistoryViewLogic = {
        let view = ParkingHistoryView()
        view.delegate = self
        view.tableView.delegate = self
        view.tableView.dataSource = self
        
        return view
    }()
    
    private var sections: [ParkingHistoryModels.Something.Section] = []
    
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
        interactor?.loadHistory()
    }
}

// MARK: - Display Logic

extension ParkingHistoryViewController: ParkingHistoryDisplayLogic {
    
    func displayHistory(_ viewModel: [ParkingHistoryModels.Something.Section]) {
        self.sections = viewModel
        guard sections.count != 0 else {
            contentView.showEmptyView(true)
            return
        }
        contentView.showEmptyView(false)
        contentView.reload()
    }
}

// MARK: - UITableViewDataSource

extension ParkingHistoryViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ParkingHistoryViewCell.reusable(for: tableView, indexPath: indexPath)
        cell.bind(with: sections[indexPath.section].records[indexPath.row])
        cell.separatorView.isHidden = indexPath.row == sections[indexPath.section].records.count - 1
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ParkingHistoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        router?.routeToInfo(sections[indexPath.section].records[indexPath.row].id)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = ParkingHistoryTableHeaderView()
        view.bind(with: sections[section].sectionTitle)
        
        return view
    }
}

extension ParkingHistoryViewController: ParkingHistoryViewDelegate {
    
    func parkingHistoryViewBackButtonDidTap(_ view: ParkingHistoryView) {
        dismiss(animated: true)
    }
}
