//  Created by Akyl Temirgaliyev on 10.04.2023.

import SnapKit
import UIKit

protocol ParkingHistoryViewLogic: UIView {
    func reload()
    func showEmptyView(_ isShow: Bool)
}

protocol ParkingHistoryViewDelegate: AnyObject {
    func parkingHistoryViewBackButtonDidTap(_ view: ParkingHistoryView)
}

final class ParkingHistoryView: UIView {
    
    weak var delegate: ParkingHistoryViewDelegate?
    
    // MARK: - Views
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back_button"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-Bold", size: 24)
        label.textColor = UIColor.mainBlue
        label.textAlignment = .left
        label.text = "Parking History".localized()
        
        return label
    }()
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.estimatedSectionHeaderHeight = 32
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = 24
        tableView.layoutMargins = .init(top: 0, left: 32, bottom: 0, right: 32)
        ParkingHistoryViewCell.register(for: tableView)
        
        return tableView
    }()
    
    private lazy var emptyView: ParkingHistoryEmptyView = {
        let view = ParkingHistoryEmptyView()
        view.isHidden = true
        
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func backButtonTap() {
        delegate?.parkingHistoryViewBackButtonDidTap(self)
    }
}

// MARK: - Private Methods

private extension ParkingHistoryView {
    
    func configure() {
        backgroundColor = .background
        setupBackButton()
        setupTitleLabel()
        setupTableView()
        setupEmptyView()
    }
    
    func setupBackButton() {
        addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.size.equalTo(40)
        }
    }
    
    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(32)
            make.top.equalTo(backButton.snp.bottom).offset(32)
        }
    }
    
    func setupTableView() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(32)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setupEmptyView() {
        addSubview(emptyView)
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(80)
            make.centerX.equalToSuperview()
        }
    }
}

// MARK: - ParkingHistoryViewLogic

extension ParkingHistoryView: ParkingHistoryViewLogic {
    
    func reload() {
        tableView.reloadData()
    }
    
    func showEmptyView(_ isShow: Bool) {
        tableView.isHidden = isShow
        emptyView.isHidden = !isShow
    }
}
