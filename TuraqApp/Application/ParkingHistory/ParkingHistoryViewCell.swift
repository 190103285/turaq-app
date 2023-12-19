//
//  ParkingHistoryViewCell.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 10.04.2023.
//

import UIKit
import SnapKit

final class ParkingHistoryViewCell: UITableViewCell, ReusableCell {
    
    private lazy var leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.image = UIImage(named: "parking_icon")
        
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 1
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-Regular", size: 16)
        label.textColor = UIColor.mainBlue
        label.text = "25 марта, 12:24"
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-Regular", size: 16)
        label.textColor = UIColor.textGray
        label.text = "ул. Байтурсынова"
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var accessoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "next_icon")
        
        return imageView
    }()
    
    private(set) lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.textGray.withAlphaComponent(0.5)
        
        return view
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(with model: ParkingHistoryModels.Something.Record) {
        dateLabel.text = model.dateText
        addressLabel.text = model.parkingName
    }
}

// MARK: - Private Methods

private extension ParkingHistoryViewCell {
    
    func setup() {
        setupLeftImageView()
        setupStackView()
        setupAccessoryImageView()
        setupSeparator()
    }
    
    func setupLeftImageView() {
        addSubview(leftImageView)
        leftImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
            make.size.equalTo(24)
        }
    }
    
    func setupStackView() {
        addSubview(stackView)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(addressLabel)
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(leftImageView.snp.trailing).offset(16)
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-14)
            make.trailing.equalToSuperview().offset(-60)
        }
    }
    
    func setupAccessoryImageView() {
        addSubview(accessoryImageView)
        accessoryImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    func setupSeparator() {
        addSubview(separatorView)
        separatorView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
}
