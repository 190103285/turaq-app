//
//  HelpViewFooterView.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 25.04.2023.
//

import UIKit

final class HelpViewFooterView: UIView {
    
    // MARK: - Private Properties

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-Regular", size: 12)
        label.textColor = UIColor.textGray
        
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-Regular", size: 12)
        label.textColor = UIColor.textGray
        label.text = "OOO TuraqApp"
        
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private

private extension HelpViewFooterView {
    
    func setup() {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        titleLabel.text = "Версия \(version)"
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
        }
        
        addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.centerX.equalToSuperview()
        }
    }
}
