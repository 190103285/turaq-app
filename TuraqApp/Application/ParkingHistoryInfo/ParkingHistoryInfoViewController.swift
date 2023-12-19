//  Created by Akyl Temirgaliyev on 12.04.2023.

import UIKit

protocol ParkingHistoryInfoDisplayLogic: AnyObject {
    func displayInfo(_ viewModel: ParkingHistoryInfoModels.Info.ViewModel)
}

final class ParkingHistoryInfoViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var interactor: ParkingHistoryInfoBusinessLogic?
    var router: (ParkingHistoryInfoRoutingLogic & ParkingHistoryInfoDataPassing)?
    
    // MARK: - Private Properties
    
    private lazy var contentView: ParkingHistoryInfoViewLogic = {
        let view = ParkingHistoryInfoView()
        view.tableView.delegate = self
        view.tableView.dataSource = self
        
        return view
    }()
    
    private var rows: [ParkingHistoryInfoModels.Info.RowType] = []
    private var headerModel: ParkingHistoryInfoModels.Info.ReceiptModel?
    
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
        interactor?.loadRecord()
    }
}

// MARK: - Display Logic

extension ParkingHistoryInfoViewController: ParkingHistoryInfoDisplayLogic {
    
    func displayInfo(_ viewModel: ParkingHistoryInfoModels.Info.ViewModel) {
        self.headerModel = viewModel.headerModel
        self.rows = viewModel.sections
        contentView.reload()
    }
}

extension ParkingHistoryInfoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section != 0 {
            router?.routeToChat()
        }
    }
}

extension ParkingHistoryInfoViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? rows.count : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            switch rows[indexPath.row] {
            case .time(model: let model):
                let cell = ParkingHistoryInfoTimeViewCell.reusable(for: tableView, indexPath: indexPath)
                cell.bind(with: model)
                cell.selectionStyle = .none
                
                return cell
            case .car(model: let model):
                let cell = ParkingHistoryInfoCarViewCell.reusable(for: tableView, indexPath: indexPath)
                cell.bind(with: model)
                cell.selectionStyle = .none
                
                return cell
            case .payment(model: let model):
                let cell = ParkingHistoryInfoPaymentViewCell.reusable(for: tableView, indexPath: indexPath)
                cell.bind(with: model)
                cell.selectionStyle = .none
                
                return cell
            }
        } else {
            let cell = MenuHelpViewCell.reusable(for: tableView, indexPath: indexPath)
            cell.setTitle("Support Chat".localized())
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerModel else {
            return nil
        }
        if section == 0 {
            let view = ParkingHistoryInfoHeaderView()
            view.bind(with: headerModel.header)
            
            return view
        } else if section == 1 {
            let view = ParkingHistoryInfoReceiptView()
            view.bind(with: headerModel)
            
            return view
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 71 : 170
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 0 ? 32 : 0
    }
}
