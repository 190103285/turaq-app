//  Created by Akyl Temirgaliyev on 12.04.2023.

import SnapKit
import UIKit

protocol ParkingHistoryInfoViewLogic: UIView {
    func reload()
}

final class ParkingHistoryInfoView: UIView {
    
    // MARK: - Views
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableView.automaticDimension
        tableView.layoutMargins = .init(top: 0, left: 32, bottom: 0, right: 32)
        tableView.backgroundColor = .background
        ParkingHistoryInfoPaymentViewCell.register(for: tableView)
        ParkingHistoryInfoCarViewCell.register(for: tableView)
        ParkingHistoryInfoTimeViewCell.register(for: tableView)
        MenuHelpViewCell.register(for: tableView)
        
        return tableView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        addSubviews()
    }
    
    private func addSubviews() {
        backgroundColor = .background
        
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-8)
        }
    }
}

// MARK: - ParkingHistoryInfoViewLogic

extension ParkingHistoryInfoView: ParkingHistoryInfoViewLogic {
    
    func reload() {
        tableView.reloadData()
    }
}
