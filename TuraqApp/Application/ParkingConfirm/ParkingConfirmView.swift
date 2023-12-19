//
//  ParkingConfirmView.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 12.04.2023.
//

import SnapKit
import UIKit
import GoogleMaps

protocol ParkingConfirmViewLogic: UIView {
    func bind(with model: ParkingConfirmFlow.Something.ViewModel)
    func updateSelectedCar(_ model: ParkingConfirmFlow.SelectedCar.ViewModel)
    func updateSelectedCard(_ model: ParkingConfirmFlow.SelectedCard.ViewModel)
}

protocol ParkingConfirmViewDelegate: AnyObject {
    func parkingConfirmViewConfirmDidTap(_ view: ParkingConfirmView, request: ParkingConfirmFlow.Something.Request)
    func parkingConfirmViewSelectCarDidTap(_ view: ParkingConfirmView)
    func parkingConfirmViewSelectCardDidTap(_ view: ParkingConfirmView)
    func parkingConfirmViewBackButtonDidTap(_ view: ParkingConfirmView)
}

final class ParkingConfirmView: UIView {
    
    weak var delegate: ParkingConfirmViewDelegate?
    
    // MARK: - Views
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back_button"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-Bold", size: 24)
        label.textColor = UIColor.mainBlue
        label.textAlignment = .center
        label.text = "Confirm the data".localized()
        
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-Regular", size: 16)
        label.textColor = UIColor.textGray
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var mapContainerView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.image = UIImage(named: "parking_image")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var optionsContainerView: ParkingConfirmOptionsView = {
        let view = ParkingConfirmOptionsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.delegate = self
        
        return view
    }()
    
    private lazy var timeView: ParkingConfirmTimeView = {
        let view = ParkingConfirmTimeView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var totalView: ParkingConfirmTotalPriceView = {
        let view = ParkingConfirmTotalPriceView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.mainBlue
        button.setTitle("Confirm".localized(), for: [])
        button.titleLabel?.font = UIFont(name: "NunitoSans-Regular", size: 16)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(confirmDidTap), for: .touchUpInside)
        
        return button
    }()
    
    var model: ParkingConfirmFlow.Something.ViewModel?
    var startTime: Date = Date()
    var endTime: Date = Date().addingTimeInterval(3600)
    
    // MARK: - Init
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods

private extension ParkingConfirmView {
    
    func configure() {
        backgroundColor = .background
        addSubviews()
    }
    
    func addSubviews() {
        addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.size.equalTo(40)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(32)
        }
        
        addSubview(mapContainerView)
        mapContainerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
            make.top.equalTo(titleLabel.snp.bottom).offset(48)
            make.height.equalTo(100)
        }
        
        addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(mapContainerView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(42)
        }
        
        addSubview(optionsContainerView)
        optionsContainerView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
        }
        
        addSubview(timeView)
        timeView.snp.makeConstraints { make in
            make.top.equalTo(optionsContainerView.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.height.equalTo(64)
        }
        
        addSubview(totalView)
        totalView.snp.makeConstraints { make in
            make.top.equalTo(timeView.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
        }
        
        addSubview(confirmButton)
        confirmButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-48)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
            make.height.equalTo(48)
        }
    }
}

// MARK: - Actions

private extension ParkingConfirmView {
    
    @objc
    func confirmDidTap() {
        let request = ParkingConfirmFlow.Something.Request(parkingId: model?.parkingId ?? 0, startTime: startTime, endTime: endTime)
        delegate?.parkingConfirmViewConfirmDidTap(self, request: request)
    }
    
    @objc
    func backButtonTap() {
        delegate?.parkingConfirmViewBackButtonDidTap(self)
    }
}

// MARK: - ParkingConfirmViewLogic

extension ParkingConfirmView: ParkingConfirmViewLogic {
    
    func bind(with model: ParkingConfirmFlow.Something.ViewModel) {
        self.model = model
        subtitleLabel.text = model.parkingName
        optionsContainerView.bind(with: model.selectedCarName, cardName: model.selectedCardName, cardType: model.selectedCardType)
        totalView.bind(with: "1 час", price: String(model.placePrice))
    }
    
    func updateSelectedCar(_ model: ParkingConfirmFlow.SelectedCar.ViewModel) {
        
    }
    
    func updateSelectedCard(_ model: ParkingConfirmFlow.SelectedCard.ViewModel) {
        
    }
}

// MARK: - ParkingConfirmOptionsViewDelegate

extension ParkingConfirmView: ParkingConfirmOptionsViewDelegate {
    
    func cardSelectDidTap() {
        delegate?.parkingConfirmViewSelectCardDidTap(self)
    }
    
    func carSelectDidTap() {
        delegate?.parkingConfirmViewSelectCarDidTap(self)
    }
}

// MARK: - ParkingConfirmTimeViewDelegate

extension ParkingConfirmView: ParkingConfirmTimeViewDelegate {
    
    func didUpdateTime(_ startTime: Date, _ endTime: Date) {
        self.startTime = startTime
        self.endTime = endTime
        guard let model else {
            return
        }
        let timeInterval = Int(endTime.timeIntervalSince(startTime))
        let minutes = (timeInterval / 60)
        let priceInMinutes = Double(model.placePrice) // PRICE PER MINUTES
        let finalPrice = Double(minutes) * priceInMinutes
        let finalPriceString = String(finalPrice)
        
        totalView.bind(
            with: Formatter.formatTimeInterval(start: startTime, end: endTime),
            price: finalPriceString
        )
    }
}
