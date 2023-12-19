//
//  MyCardsView.swift
//  TuraqApp
//
//  Created by Akyl on 07.03.2023.
//

import SnapKit
import UIKit

protocol MyCardsViewLogic: UIView {
    func reload()
    func stopLoading()
}

protocol MyCardsViewDelegate: AnyObject {
    func myCardsViewBackButtonDidTap(_ view: MyCardsView)
}

final class MyCardsView: UIView {
    
    weak var delegate: MyCardsViewDelegate?
    
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
        MyCardsViewCell.register(for: tableView)
        AddCardViewCell.register(for: tableView)
        
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
        delegate?.myCardsViewBackButtonDidTap(self)
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

// MARK: - MyCardsViewLogic

extension MyCardsView: MyCardsViewLogic {
    
    func reload() {
        tableView.reloadData()
    }
    
    func stopLoading() {
        tableView.refreshControl?.endRefreshing()
    }
}
