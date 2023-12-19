//  Created by Akyl on 01.03.2023.

import SnapKit
import UIKit

protocol ProfileViewLogic: UIView {
    func reload()
    func startSkeletonLoading()
    func stopSkeletonLoading()
    func stopLoading()
}

protocol ProfileViewDelegate: AnyObject {
    func profileViewBackButtonDidTap(_ view: ProfileView)
}

final class ProfileView: UIView {
    
    weak var delegate: ProfileViewDelegate?
    
    // MARK: - Views
    
    private lazy var skeletonView: ProfileViewSkeletonView = ProfileViewSkeletonView()
    
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
        tableView.sectionFooterHeight = 0
        tableView.layoutMargins = .init(top: 0, left: 32, bottom: 0, right: 32)
        tableView.refreshControl = refreshControl
        ProfileViewDataCell.register(for: tableView)
        ProfileViewSettingsCell.register(for: tableView)
        ProfileViewLogoutCell.register(for: tableView)
        ProfileViewDeleteAccountCell.register(for: tableView)
        
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
        delegate?.profileViewBackButtonDidTap(self)
    }
}

// MARK: - Private Methods

private extension ProfileView {
    
    func configure() {
        backgroundColor = .background
        setupSubviews()
    }
    
    func setupSubviews() {
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
        
        addSubview(skeletonView)
        skeletonView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(32)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-4)
        }
    }
}

// MARK: - ProfileViewLogic

extension ProfileView: ProfileViewLogic {
    
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
    
    func stopLoading() {
        tableView.refreshControl?.endRefreshing()
    }
}
