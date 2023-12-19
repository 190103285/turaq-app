//
//  MenuProfileViewCell.swift
//  TuraqApp
//
//  Created by Akyl on 12.03.2023.
//

import UIKit

final class MenuProfileViewCell: UITableViewCell, ReusableCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.textGray
        label.font = UIFont(name: "NunitoSans-Semibold", size: 16)
        label.text = "Profile".localized()
        label.sizeToFit()
        
        return label
    }()
    
    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mainBlue
        label.font = UIFont(name: "NunitoSans-Semibold", size: 16)
        label.sizeToFit()
        
        return label
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "next_icon")
        
        return imageView
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func bind(with phoneNumber: String) {
        phoneNumberLabel.text = phoneNumber
    }
}

// MARK: - Private Methods

private extension MenuProfileViewCell {
    
    func setup() {
        setupSkeleton()
        setupTitleLabel()
        setupPhoneNumberLabel()
        setupIconImageView()
    }
    
    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(10)
        }
    }
    
    func setupPhoneNumberLabel() {
        addSubview(phoneNumberLabel)
        phoneNumberLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func setupIconImageView() {
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }
    }
    
    func setupSkeleton() {
        makeSkeletonable(self)
    }
}
