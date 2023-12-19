//
//  ParkingHistoryInfoPaymentViewCell.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 23.04.2023.
//

import UIKit

final class ParkingHistoryInfoPaymentViewCell: UITableViewCell, ReusableCell {
    
    private lazy var leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.tintColor = UIColor.mainBlue
        imageView.image = UIImage(named: "card_icon")
        
        return imageView
    }()
    
    private lazy var titleStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 1
        view.distribution = .fillEqually
        view.alignment = .leading
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mainBlue
        label.font = UIFont(name: "NunitoSans-SemiBold", size: 16)
        
        return label
    }()
    
    private lazy var cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.tintColor = UIColor.mainBlue
        
        return imageView
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mainBlue
        label.font = UIFont(name: "NunitoSans-SemiBold", size: 16)
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.textGray.withAlphaComponent(0.5)
        
        return view
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
    
    func bind(with model: ParkingHistoryInfoModels.Info.PaymentModel) {
        titleLabel.text = model.paymentTitle
        cardImageView.image = UIImage(named: model.paymentType)
        valueLabel.text = model.paymentCardId
    }
    
    // MARK: - Private
    
    private func setup() {
        backgroundColor = .white
        addSubview(leftImageView)
        leftImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(24)
            make.centerY.equalToSuperview()
        }
        
        addSubview(titleStackView)
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(cardImageView)
        titleStackView.snp.makeConstraints { make in
            make.leading.equalTo(leftImageView.snp.trailing).offset(24)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        addSubview(valueLabel)
        valueLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
    }
}

