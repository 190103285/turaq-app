//
//  ProfileViewSkeletonView.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 02.05.2023.
//

import UIKit

final class ProfileViewSkeletonView: UIView {
    
    // MARK: - Private Properties
    
    private lazy var bigStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 32
        stack.backgroundColor = .clear
        stack.distribution = .fill
        
        return stack
    }()
    
    private lazy var profileStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.backgroundColor = .clear
        stack.distribution = .fill
        
        return stack
    }()
    
    private lazy var settingsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.backgroundColor = .clear
        stack.distribution = .fill
        
        return stack
    }()
    
    private lazy var smallStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.backgroundColor = .clear
        stack.distribution = .fillEqually
        
        return stack
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private

private extension ProfileViewSkeletonView {
    
    func setup() {
        isSkeletonable = true
        bigStackView.isSkeletonable = true
        profileStackView.isSkeletonable = true
        settingsStackView.isSkeletonable = true
        smallStackView.isSkeletonable = true
        
        let dataHeaderView = UIView()
        dataHeaderView.skeletonCornerRadius = 8
        dataHeaderView.snp.makeConstraints { make in
            make.height.equalTo(24)
        }
        dataHeaderView.isSkeletonable = true
        
        let dataView = UIView()
        dataView.skeletonCornerRadius = 8
        dataView.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        dataView.isSkeletonable = true
        
        let settingsHeaderView = UIView()
        settingsHeaderView.skeletonCornerRadius = 8
        settingsHeaderView.snp.makeConstraints { make in
            make.height.equalTo(24)
        }
        settingsHeaderView.isSkeletonable = true
        
        let settingsView = UIView()
        settingsView.skeletonCornerRadius = 8
        settingsView.snp.makeConstraints { make in
            make.height.equalTo(144)
        }
        settingsView.isSkeletonable = true
        
        let logoutView = UIView()
        logoutView.skeletonCornerRadius = 8
        logoutView.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        logoutView.isSkeletonable = true
        
        let deleteView = UIView()
        deleteView.skeletonCornerRadius = 8
        deleteView.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        deleteView.isSkeletonable = true
        
        profileStackView.addArrangedSubview(dataHeaderView)
        profileStackView.addArrangedSubview(dataView)
        settingsStackView.addArrangedSubview(settingsHeaderView)
        settingsStackView.addArrangedSubview(settingsView)
        smallStackView.addArrangedSubview(deleteView)
        smallStackView.addArrangedSubview(logoutView)
        
        bigStackView.addArrangedSubview(profileStackView)
        bigStackView.addArrangedSubview(settingsStackView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        addSubview(bigStackView)
        bigStackView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
        }
        
        addSubview(smallStackView)
        smallStackView.snp.makeConstraints { make in
            make.top.equalTo(bigStackView.snp.bottom).offset(48)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
        }
    }
}
