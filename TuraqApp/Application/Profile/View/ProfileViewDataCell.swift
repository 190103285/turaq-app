//
//  ProfileViewDataCell.swift
//  TuraqApp
//
//  Created by Akyl on 01.03.2023.
//

import UIKit

final class ProfileViewDataCell: UITableViewCell, ReusableCell {
    
    // MARK: - Private Properties
    
    private lazy var leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.tintColor = UIColor.mainBlue
        
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mainBlue
        label.font = UIFont(name: "NunitoSans-Regular", size: 16)
        label.sizeToFit()
        
        return label
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
    
    func bind(with model: ProfileModels.DataCell.Params) {
        leftImageView.image = model.image
        nameLabel.text = model.phoneNumber
    }
}

// MARK: - Private Methods

private extension ProfileViewDataCell {
    
    func setup() {
        setupLeftImageView()
        setupNameLabel()
    }
    
    func setupLeftImageView() {
        addSubview(leftImageView)
        leftImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
    }
    
    func setupNameLabel() {
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(leftImageView.snp.trailing).offset(16)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.trailing.lessThanOrEqualToSuperview().offset(-64)
        }
    }
}

