//
//  ParkingHistoryInfoTimeViewCell.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 23.04.2023.
//

import UIKit

final class ParkingHistoryInfoTimeViewCell: UITableViewCell, ReusableCell {
    
    private lazy var leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.tintColor = UIColor.mainBlue
        imageView.image = UIImage(named: "history_icon")
        
        return imageView
    }()
    
    private lazy var titleStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 16
        view.distribution = .fillEqually
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.textGray
        label.font = UIFont(name: "NunitoSans-SemiBold", size: 16)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.textGray
        label.font = UIFont(name: "NunitoSans-SemiBold", size: 16)
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var valueStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 16
        view.distribution = .fillEqually
        
        return view
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mainBlue
        label.font = UIFont(name: "NunitoSans-SemiBold", size: 16)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var valueSubtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mainBlue
        label.font = UIFont(name: "NunitoSans-SemiBold", size: 16)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
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
    
    func bind(with model: ParkingHistoryInfoModels.Info.TimeModel) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        valueLabel.text = model.startTime
        valueSubtitleLabel.text = model.timeOnParking
    }
    
    // MARK: - Private
    
    private func setup() {
        backgroundColor = .white
        
        addSubview(leftImageView)
        leftImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(20)
            make.size.equalTo(24)
        }
        
        addSubview(titleStackView)
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(subtitleLabel)
        titleStackView.snp.makeConstraints { make in
            make.leading.equalTo(leftImageView.snp.trailing).offset(24)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        addSubview(valueStackView)
        valueStackView.addArrangedSubview(valueLabel)
        valueStackView.addArrangedSubview(valueSubtitleLabel)
        valueStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
        
        addSubview(separatorView)
        separatorView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
}

