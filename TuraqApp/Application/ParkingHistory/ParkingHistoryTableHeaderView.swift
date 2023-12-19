//
//  ParkingHistoryTableHeaderView.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 11.04.2023.
//

import UIKit

final class ParkingHistoryTableHeaderView: UIView {
    
    // MARK: - Private Properties

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-Regular", size: 16)
        label.textColor = UIColor.textGray
        label.text = "Месяц 1"
        
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
    
    // MARK: - Public Method

    func bind(with title: String) {
        titleLabel.text = title
    }
}

// MARK: - Private

private extension ParkingHistoryTableHeaderView {
    
    func setup() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-8)
        }
    }
}


