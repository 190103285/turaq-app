//
//  ParkingConfirmTotalPriceView.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 16.04.2023.
//

import UIKit

final class ParkingConfirmTotalPriceView: UIView {
    
    // MARK: - Private Properties
    
    private lazy var walletImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.tintColor = UIColor.mainBlue
        imageView.image = UIImage(named: "wallet_icon")
        
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        
        return stackView
    }()
    
    private lazy var priceTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-SemiBold", size: 16)
        label.textColor = UIColor.textGray
        label.textAlignment = .left
        label.text = "Price".localized()
        
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-SemiBold", size: 14)
        label.textColor = UIColor.mainBlue
        label.textAlignment = .left
        label.text = "1 час"
        
        return label
    }()
    
    private lazy var priceValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-SemiBold", size: 16)
        label.textColor = UIColor.mainBlue
        label.textAlignment = .center
        label.text = "100 т"
        
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(with time: String, price: String) {
        priceValueLabel.text = "\(price) ₸"
        timeLabel.text = time
    }
    
    // MARK: - Private Properties
    
    private func configure() {
        addSubview(walletImageView)
        walletImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(walletImageView.snp.trailing).offset(16)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-13)
        }
        
        stackView.addArrangedSubview(priceTitleLabel)
        stackView.addArrangedSubview(timeLabel)
        
        addSubview(priceValueLabel)
        priceValueLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-24)
            make.centerY.equalToSuperview()
        }
    }
}
