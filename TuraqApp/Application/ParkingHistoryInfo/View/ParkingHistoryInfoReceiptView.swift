//
//  ParkingHistoryInfoTableHeaderView.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 23.04.2023.
//

import UIKit

final class ParkingHistoryInfoReceiptView: UIView {
    
    private lazy var initialPriceTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-Regular", size: 16)
        label.textColor = UIColor.mainBlue
        label.textAlignment = .left
        label.text = "Billing by tariff".localized()
        
        return label
    }()
    
    private lazy var initialPriceValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-SemiBold", size: 16)
        label.textColor = UIColor.mainBlue
        label.textAlignment = .left
        label.text = "300 т"
        
        return label
    }()
    
    private lazy var penaltyTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-Regular", size: 16)
        label.textColor = UIColor.mainBlue
        label.textAlignment = .left
        label.text = "Late leave".localized()
        
        return label
    }()
    
    private lazy var penaltyValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-SemiBold", size: 16)
        label.textColor = UIColor.mainBlue
        label.textAlignment = .left
        label.text = "80 т"
        
        return label
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.textGray.withAlphaComponent(0.5)
        
        return view
    }()
    
    private lazy var totalPriceTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-Regular", size: 16)
        label.textColor = UIColor.mainBlue
        label.textAlignment = .left
        label.text = "Total".localized()
        
        return label
    }()
    
    private lazy var totalPriceValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-SemiBold", size: 16)
        label.textColor = UIColor.mainBlue
        label.textAlignment = .left
        label.text = "380 т"
        
        return label
    }()
    
    private lazy var showReceiptButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.clear
        button.titleLabel?.font = UIFont(name: "NunitoSans-Regular", size: 16)
        button.setTitleColor(UIColor.middleBlue, for: .normal)
        
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(with model: ParkingHistoryInfoModels.Info.ReceiptModel) {
        initialPriceValueLabel.text = model.initialPrice
        penaltyValueLabel.text = model.penaltyPrice
        totalPriceValueLabel.text = model.totalPrice
    }
    
    private func configure() {
        backgroundColor = .background
        
        addSubview(initialPriceTitleLabel)
        initialPriceTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview()
        }
        
        addSubview(initialPriceValueLabel)
        initialPriceValueLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(initialPriceTitleLabel)
        }
        
        addSubview(penaltyTitleLabel)
        penaltyTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(initialPriceTitleLabel.snp.bottom).offset(8)
        }
        
        addSubview(penaltyValueLabel)
        penaltyValueLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(penaltyTitleLabel)
        }
        
        addSubview(separatorView)
        separatorView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(0.5)
            make.top.equalTo(penaltyTitleLabel.snp.bottom).offset(8)
        }
        
        addSubview(totalPriceTitleLabel)
        totalPriceTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(separatorView.snp.bottom).offset(8)
        }
        
        addSubview(totalPriceValueLabel)
        totalPriceValueLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(totalPriceTitleLabel)
        }
        
        addSubview(showReceiptButton)
        let attributeString = NSMutableAttributedString(
            string: "View fiscal receipt".localized(),
                attributes: [.underlineColor: UIColor.middleBlue, .underlineStyle: NSUnderlineStyle.single.rawValue]
        )
        showReceiptButton.setAttributedTitle(attributeString, for: .normal)
        showReceiptButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(totalPriceValueLabel.snp.bottom).offset(32)
        }
    }
}
