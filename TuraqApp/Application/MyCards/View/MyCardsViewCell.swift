//
//  MyCardsViewCell.swift
//  TuraqApp
//
//  Created by Akyl on 07.03.2023.
//

import UIKit

final class MyCardsViewCell: UITableViewCell, ReusableCell {
    
    struct Params {
        let id: Int
        let title: String
        let image: UIImage?
        let isSelected: Bool
    }
    
    // MARK: - Private Properties
    
    private(set) lazy var checkbox: Checkbox = {
        let button = Checkbox()
        
        return button
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-Regular", size: 16)
        label.textColor = UIColor.mainBlue
        
        return label
    }()
    
    private lazy var cardImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        
        return imageView
    }()
    
    private(set) lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.textGray.withAlphaComponent(0.5)
        
        return view
    }()
    
    override var isSelected: Bool {
        didSet {
            updateForSelected(isSelected)
        }
    }
    
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
        cardImage.image = model.image
        isSelected = model.isSelected
    }
    
    func updateForSelected(_ isSelected: Bool) {
        checkbox.isSelected = isSelected
    }
}

// MARK: - Private Methods

private extension MyCardsViewCell {
    
    func setup() {
        selectionStyle = .none
        setupSubviews()
    }
    
    func setupSubviews() {
        contentView.addSubview(checkbox)
        contentView.addSubview(nameLabel)
        contentView.addSubview(cardImage)
        contentView.addSubview(separatorView)
        
        checkbox.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(16)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkbox.snp.trailing).offset(16)
            make.trailing.lessThanOrEqualToSuperview().offset(-16)
            make.top.equalToSuperview().offset(16)
            make.bottom.lessThanOrEqualToSuperview().offset(-10)
        }
        
        cardImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.width.equalTo(32)
            make.height.equalTo(16)
        }
        
        separatorView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
}



