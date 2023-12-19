//
//  MenuViewSkeletonView.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 14.04.2023.
//

import UIKit

final class MenuViewSkeletonView: UIView {
    
    // MARK: - Private Properties
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.backgroundColor = .clear
        stack.distribution = .fill
        
        return stack
    }()
    
    private lazy var mysStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
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

private extension MenuViewSkeletonView {
    
    func setup() {
        isSkeletonable = true
        stackView.isSkeletonable = true
        mysStackView.isSkeletonable = true
        
        let profileView = UIView()
        profileView.skeletonCornerRadius = 8
        profileView.snp.makeConstraints { make in
            make.height.equalTo(64)
        }
        profileView.isSkeletonable = true
        
        let myCarsView = UIView()
        myCarsView.skeletonCornerRadius = 8
        myCarsView.snp.makeConstraints { make in
            make.height.equalTo(120)
        }
        myCarsView.isSkeletonable = true
        
        let myCardsView = UIView()
        myCardsView.skeletonCornerRadius = 8
        myCardsView.snp.makeConstraints { make in
            make.height.equalTo(120)
        }
        myCardsView.isSkeletonable = true
        
        let helpView = UIView()
        helpView.skeletonCornerRadius = 8
        helpView.snp.makeConstraints { make in
            make.height.equalTo(64)
        }
        helpView.isSkeletonable = true
        
        let historyView = UIView()
        historyView.skeletonCornerRadius = 8
        historyView.snp.makeConstraints { make in
            make.height.equalTo(64)
        }
        historyView.isSkeletonable = true
        
        mysStackView.addArrangedSubview(myCarsView)
        mysStackView.addArrangedSubview(myCardsView)
        stackView.addArrangedSubview(profileView)
        stackView.addArrangedSubview(mysStackView)
        stackView.addArrangedSubview(helpView)
        stackView.addArrangedSubview(historyView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.bottom.equalToSuperview().offset(-32)
        }
    }
}
