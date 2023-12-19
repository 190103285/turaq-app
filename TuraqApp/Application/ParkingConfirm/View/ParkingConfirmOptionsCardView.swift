//
//  CardView.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 15.04.2023.
//

import UIKit

protocol ParkingConfirmOptionsCardViewDelegate: AnyObject {
    func cardSelectDidTap()
}

final class ParkingConfirmOptionsCardView: UIView {
    
    weak var delegate: ParkingConfirmOptionsCardViewDelegate?
    
    // MARK: - Private Properties
    
    private lazy var gestureRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        return recognizer
    }()
    
    private lazy var cardLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-Regular", size: 16)
        label.textColor = UIColor.textGray
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.tintColor = UIColor.mainBlue
        imageView.image = UIImage(named: "card_icon")
        
        return imageView
    }()
    
    private lazy var cardTypeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        
        return imageView
    }()
    
    private lazy var cardMoreButtonImageView: UIImageView = {
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
    
    func bind(with cardName: String, cardType: String) {
        cardLabel.text = cardName
        cardTypeImageView.image = UIImage(named: cardType)
    }
}

// MARK: - Private Methods

private extension ParkingConfirmOptionsCardView {
    
    func configure() {
        backgroundColor = .white
        addGestureRecognizer(gestureRecognizer)
        addSubview(cardImageView)
        cardImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(14)
            make.bottom.equalToSuperview().offset(-10)
            make.size.equalTo(24)
        }
        
        addSubview(cardTypeImageView)
        cardTypeImageView.snp.makeConstraints { make in
            make.leading.equalTo(cardImageView.snp.trailing).offset(16)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.width.equalTo(32)
            make.height.equalTo(16)
        }
        
        addSubview(cardLabel)
        cardLabel.snp.makeConstraints { make in
            make.leading.equalTo(cardTypeImageView.snp.trailing).offset(4)
            make.centerY.equalToSuperview()
        }
        
        addSubview(cardMoreButtonImageView)
        cardMoreButtonImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    @objc
    func didTap(_ recognizer: UIGestureRecognizer) {
        delegate?.cardSelectDidTap()
    }
}
