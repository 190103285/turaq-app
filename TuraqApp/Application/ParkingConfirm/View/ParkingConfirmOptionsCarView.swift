//
//  CarView.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 15.04.2023.
//

import UIKit

protocol ParkingConfirmOptionsCarViewDelegate: AnyObject {
    func carSelectDidTap()
}

final class ParkingConfirmOptionsCarView: UIView {
    
    weak var delegate: ParkingConfirmOptionsCarViewDelegate?
    
    // MARK: - Private Properties
    
    private lazy var gestureRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        return recognizer
    }()
    
    private lazy var carImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.tintColor = UIColor.mainBlue
        imageView.image = UIImage(named: "car_icon")
        
        return imageView
    }()
    
    private lazy var carLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-Regular", size: 16)
        label.textColor = UIColor.mainBlue
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var carMoreButtonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.tintColor = UIColor.mainBlue
        imageView.image = UIImage(named: "more_button_icon")
        
        return imageView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func bind(with carName: String) {
        carLabel.text = carName
    }
}

// MARK: - Private Methods

private extension ParkingConfirmOptionsCarView {
    
    func configure() {
        addGestureRecognizer(gestureRecognizer)
        backgroundColor = .white
        addSubview(carImageView)
        carImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(14)
            make.bottom.equalToSuperview().offset(-10)
            make.size.equalTo(24)
        }
        
        addSubview(carLabel)
        carLabel.snp.makeConstraints { make in
            make.leading.equalTo(carImageView.snp.trailing).offset(16)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        addSubview(carMoreButtonImageView)
        carMoreButtonImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    @objc
    func didTap(_ recognizer: UIGestureRecognizer) {
        delegate?.carSelectDidTap()
    }
}

