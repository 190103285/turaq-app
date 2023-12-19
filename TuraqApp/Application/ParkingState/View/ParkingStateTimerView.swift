//
//  ParkingStateTimerView.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 16.04.2023.
//

import UIKit

final class ParkingStateTimerView: UIView {
    
    // MARK: - Views
    
    private lazy var actionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-SemiBold", size: 16)
        label.textColor = UIColor.mainBlue
        label.textAlignment = .center
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-Bold", size: 44)
        label.textColor = UIColor.mainBlue
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        
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
    
    // MARK: - Internal Methods
    
    func bind(_ actionText: String) {
        actionTitleLabel.text = actionText
//        timerLabel.text = ""
//        timerLabel.textColor = .white
//        layer.borderColor = UIColor.lightestBlue.cgColor
    }
    
    func setTime(_ time: NSMutableAttributedString) {
        timerLabel.attributedText = time
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        addSubviews()
    }
    
    private func addSubviews() {
        layer.borderColor = UIColor.lightestBlue.cgColor
        layer.borderWidth = 8
        layer.cornerRadius = 120
        backgroundColor = .white
        
        addSubview(actionTitleLabel)
        actionTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(56)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(47.5)
            make.trailing.equalToSuperview().offset(-47.5)
        }
        
        addSubview(timerLabel)
        timerLabel.snp.makeConstraints { make in
            make.top.equalTo(actionTitleLabel.snp.bottom).offset(11)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
    }
}
