//
//  MyCarsView.swift
//  TuraqApp
//
//  Created by Akyl on 05.03.2023.
//

import SnapKit
import UIKit

protocol MyCarsViewLogic: UIView {
    func reload()
    func stopLoading()
}

protocol MyCarsViewDelegate: AnyObject {
    func myCarsViewBackButtonDidTap(_ view: MyCarsView)
}

final class MyCarsView: UIView {
    
    weak var delegate: MyCarsViewDelegate?
    
    // MARK: - Views
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back_button"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
        
        return button
    }()
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.estimatedSectionHeaderHeight = 16
        tableView.estimatedRowHeight = 48
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = 32
        tableView.layoutMargins = .init(top: 0, left: 32, bottom: 0, right: 32)
        tableView.refreshControl = refreshControl
        MyCarsViewCell.register(for: tableView)
        AddCarViewCell.register(for: tableView)
        
        return tableView
    }()
    
    private(set) lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        
        return refreshControl
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
        delegate?.myCarsViewBackButtonDidTap(self)
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        backgroundColor = .background
        setupSubviews()
    }
    
    private func setupSubviews() {
        addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.size.equalTo(40)
        }
        
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - MyCarsViewLogic

extension MyCarsView: MyCarsViewLogic {
    
    func reload() {
        tableView.reloadData()
    }
    
    func stopLoading() {
        tableView.refreshControl?.endRefreshing()
    }
}
