//
//  ParkingHistoryInfoViewTitleHeaderView.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 26.04.2023.
//

import UIKit

final class ParkingHistoryInfoHeaderView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-Bold", size: 24)
        label.textColor = UIColor.mainBlue
        label.textAlignment = .center
        
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
    
    func bind(with text: String) {
        titleLabel.text = text
    }
    
    private func configure() {
        backgroundColor = .background
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
        }
    }
}

