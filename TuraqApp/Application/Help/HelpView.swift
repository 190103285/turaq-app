//
//  HelpView.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 24.04.2023.
//

import SnapKit
import UIKit

protocol HelpViewLogic: UIView {
    func reload()
}

protocol HelpViewDelegate: AnyObject {
    func helpViewBackButtonDidTap(_ view: HelpView)
}

final class HelpView: UIView {
    
    weak var delegate: HelpViewDelegate?
    
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
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableView.automaticDimension
        tableView.layoutMargins = .init(top: 0, left: 32, bottom: 0, right: 32)
        HelpViewCell.register(for: tableView)
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
    
    @objc
    private func backButtonTap() {
        delegate?.helpViewBackButtonDidTap(self)
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        backgroundColor = .background
        
        addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.size.equalTo(40)
        }
        
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(backButton.snp.bottom).offset(16)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
    }
}

// MARK: - HelpViewLogic

extension HelpView: HelpViewLogic {
    
    func reload() {
        tableView.reloadData()
    }
}
