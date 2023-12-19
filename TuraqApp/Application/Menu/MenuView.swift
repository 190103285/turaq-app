//
//  MenuView.swift
//  TuraqApp
//
//  Created by Akyl on 12.03.2023.
//

import SnapKit
import UIKit

protocol MenuViewLogic: UIView {
    func reload()
    func startSkeletonLoading()
    func stopSkeletonLoading()
}

final class MenuView: UIView {

    // MARK: - Views
    
    private lazy var skeletonView: MenuViewSkeletonView = MenuViewSkeletonView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-Bold", size: 24)
        label.textColor = UIColor.mainBlue
        label.textAlignment = .center
        label.text = "Menu".localized()
        
        return label
    }()
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.alwaysBounceVertical = false
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = 16
        tableView.sectionHeaderHeight = .zero
        tableView.isHidden = true
        tableView.layoutMargins = .init(top: 0, left: 32, bottom: 0, right: 32)
        MenuProfileViewCell.register(for: tableView)
        MenuMysViewCell.register(for: tableView)
        MenuHelpViewCell.register(for: tableView)
        MenuHistoryViewCell.register(for: tableView)
        
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
}

// MARK: - Private Methods

private extension MenuView {
        
    func configure() {
        backgroundColor = .background
        setupTitleLabel()
        setupTableView()
        setupSkeletomView()
    }
    
    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(23)
            make.centerX.equalToSuperview()
            make.height.equalTo(26)
        }
    }
    
    func setupTableView() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-4)
        }
    }
    
    func setupSkeletomView() {
        addSubview(skeletonView)
        skeletonView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-4)
        }
    }
}

// MARK: - MenuViewLogic

extension MenuView: MenuViewLogic {
    
    func reload() {
        tableView.reloadData()
    }
    
    func startSkeletonLoading() {
        tableView.isHidden = true
        skeletonView.isHidden = false
        skeletonView.showAnimatedSkeleton()
    }
    
    func stopSkeletonLoading() {
        tableView.isHidden = false
        skeletonView.isHidden = true
        skeletonView.hideSkeletonAnimation()
    }
}
