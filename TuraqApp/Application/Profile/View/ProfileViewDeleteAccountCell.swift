//
//  ProfileViewDeleteAccountCell.swift
//  TuraqApp
//
//  Created by Akyl on 01.03.2023.
//

import UIKit

final class ProfileViewDeleteAccountCell: UITableViewCell, ReusableCell {
    
    struct Params {
        let userId: Int
        let title: String
        let typeImage: UIImage
    }
    
    // MARK: - Private Properties
    
    private lazy var typeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.image = UIImage(named: "delete_icon")
        
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-Regular", size: 16)
        label.textColor = UIColor.mainBlue
        label.text = "Удалить аккаунт"
        
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Method

    func bind(with model: Params) {
        nameLabel.text = model.title
        typeImageView.image = model.typeImage
    }
}

// MARK: - Private Methods

private extension ProfileViewDeleteAccountCell {
    
    func setup() {
        setupSubviews()
    }
    
    func setupSubviews() {
        contentView.addSubview(typeImageView)
        contentView.addSubview(nameLabel)
        
        typeImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.verticalEdges.equalTo(UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0))
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(typeImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
    }
}
