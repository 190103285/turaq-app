//
//  ParkingConfirmOptionsView.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 15.04.2023.
//

import UIKit

protocol ParkingConfirmOptionsViewDelegate: AnyObject {
    func cardSelectDidTap()
    func carSelectDidTap()
}

final class ParkingConfirmOptionsView: UIView {
    
    weak var delegate: ParkingConfirmOptionsViewDelegate?
    
    // MARK: - Private Properties
    
    private lazy var carView: ParkingConfirmOptionsCarView = {
        let view = ParkingConfirmOptionsCarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.delegate = self
        
        return view
    }()
    
    private lazy var cardView: ParkingConfirmOptionsCardView = {
        let view = ParkingConfirmOptionsCardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.delegate = self
        
        return view
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.textGray.withAlphaComponent(0.5)
        
        return view
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
    
    func bind(with carName: String, cardName: String, cardType: String) {
        carView.bind(with: carName)
        cardView.bind(with: cardName, cardType: cardType)
    }
    
    func updateSelectedCar(_ carName: String) {
        carView.bind(with: carName)
    }
    
    func updateSelectedCard(_ cardName: String, _ cardType: String) {
        cardView.bind(with: cardName, cardType: cardType)
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        isUserInteractionEnabled = true
        backgroundColor = .white
        
        addSubview(carView)
        carView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        addSubview(separatorView)
        separatorView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(carView.snp.bottom)
            make.height.equalTo(0.5)
        }
        
        addSubview(cardView)
        cardView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(separatorView.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }
}

extension ParkingConfirmOptionsView: ParkingConfirmOptionsCardViewDelegate, ParkingConfirmOptionsCarViewDelegate {
    
    func cardSelectDidTap() {
        delegate?.cardSelectDidTap()
    }
    
    func carSelectDidTap() {
        delegate?.carSelectDidTap()
    }
}
