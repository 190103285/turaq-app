//
//  ParkingStateView.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 16.04.2023.
//

import SnapKit
import UIKit

protocol ParkingStateViewLogic: UIView {
    func bind(with model: MainFlow.Status.ParkingStatusViewModel)
    func updateTimerTime(timeString: String)
}

protocol ParkingStateViewDelegate: AnyObject {
    func hideDidTap()
    func leaveDidTap(_ request: ParkingStateModels.Leave.Request)
    func cancelBooking(with id: Int)
    func park(with id: Int)
}

final class ParkingStateView: UIView {
    
    enum ActionType {
        case parked
        case booked
    }
    
    weak var delegate: ParkingStateViewDelegate?
    
    // MARK: - Views
    
    private lazy var parkingTimerView: ParkingStateTimerView = {
        let view = ParkingStateTimerView()
        
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .background
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    private lazy var parkingNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-SemiBold", size: 16)
        label.textColor = UIColor.textGray
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var bookingPlaceholderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-Bold", size: 16)
        label.textColor = UIColor.mainBlue
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = "Your parking lot is waiting for you!".localized()
        
        return label
    }()
    
    private lazy var carContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    private lazy var carImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.tintColor = UIColor.mainBlue
        imageView.image = UIImage(named: "car_icon")
        
        return imageView
    }()
    
    private lazy var carNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-SemiBold", size: 16)
        label.textColor = UIColor.textGray
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var carRegNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-SemiBold", size: 16)
        label.textColor = UIColor.textGray
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    private lazy var parkAnotherButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.disabledGray
        button.titleLabel?.font = UIFont(name: "NunitoSans-Regular", size: 16)
        button.setTitleColor(.mainBlue, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(parkAnotherDidTap), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var leaveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.mainBlue
        button.titleLabel?.font = UIFont(name: "NunitoSans-Regular", size: 16)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(leaveButtonDidTap), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var hideButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont(name: "NunitoSans-Regular", size: 16)
        button.setTitleColor(UIColor.middleBlue, for: .normal)
        button.addTarget(self, action: #selector(hideButtonDidTap), for: .touchUpInside)
        
        return button
    }()
    
    private var model: MainFlow.Status.ParkingStatusViewModel?
    
    // MARK: - Init
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Actions

private extension ParkingStateView {
    
    @objc
    func hideButtonDidTap() {
        delegate?.hideDidTap()
    }
    
    @objc
    func parkAnotherDidTap() {
        guard let model else {
            return
        }
        
        if model.type == .parked {
            
        } else {
            delegate?.cancelBooking(with: model.parkingId)
        }
    }
    
    @objc
    func leaveButtonDidTap() {
        guard let model else {
            return
        }
        if model.type == .parked {
            let request = ParkingStateModels.Leave.Request(parkingId: model.parkingId, carId: model.carId)
            delegate?.leaveDidTap(request)
        } else {
            delegate?.park(with: model.parkingId)
        }
    }
}

// MARK: - Private Methods

private extension ParkingStateView {
    
    func configure() {
        addSubviews()
    }
    
    func addSubviews() {
        backgroundColor = .clear
        
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.top.equalTo(snp.centerY).offset(80)
        }
        
        addSubview(parkingTimerView)
        parkingTimerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(containerView.snp.top).offset(-35)
            make.height.width.equalTo(240)
        }
        
        addSubview(parkingNameLabel)
        parkingNameLabel.snp.makeConstraints { make in
            make.top.equalTo(parkingTimerView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
        
        addSubview(bookingPlaceholderLabel)
        bookingPlaceholderLabel.snp.makeConstraints { make in
            make.top.equalTo(parkingNameLabel.snp.bottom).offset(15)
            make.width.equalTo(222)
            make.centerX.equalToSuperview()
        }
        
        addSubview(carContainerView)
        carContainerView.snp.makeConstraints { make in
            make.top.equalTo(parkingNameLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
            make.height.equalTo(48)
        }
        
        carContainerView.addSubview(carImageView)
        carImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(24)
            make.top.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-12)
        }
        
        carContainerView.addSubview(carNameLabel)
        carNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(carImageView.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
        }
        
        carContainerView.addSubview(carRegNumberLabel)
        carRegNumberLabel.snp.makeConstraints { make in
            make.leading.equalTo(carNameLabel.snp.trailing).offset(2)
            make.centerY.equalToSuperview()
        }
        
        addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(parkAnotherButton)
        buttonStackView.addArrangedSubview(leaveButton)
        buttonStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(carContainerView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
        }
        
        parkAnotherButton.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        
        leaveButton.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        
        addSubview(hideButton)
        hideButton.snp.makeConstraints { make in
            make.top.equalTo(buttonStackView.snp.bottom).offset(24)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-8)
            make.centerX.equalToSuperview()
        }
        configureHideButtonText()
    }
    
    func configureHideButtonText() {
        let attributeString = NSMutableAttributedString(
            string: "Hide parking status".localized(),
                attributes: [.underlineColor: UIColor.middleBlue, .underlineStyle: NSUnderlineStyle.single.rawValue]
        )
        hideButton.setAttributedTitle(attributeString, for: .normal)
    }
}

// MARK: - ParkingStateViewLogic

extension ParkingStateView: ParkingStateViewLogic {
    
    func bind(with model: MainFlow.Status.ParkingStatusViewModel) {
        self.model = model
        parkingNameLabel.text = model.parkingName
        parkAnotherButton.setTitle(model.secondaryButtonTitle, for: .normal)
        leaveButton.setTitle(model.primaryButtonTitle, for: .normal)
        bookingPlaceholderLabel.isHidden = !(model.type == .booked)
        carContainerView.isHidden = (model.type == .booked)
        if model.type == .parked {
            carRegNumberLabel.text = model.carRegNumber
            carNameLabel.text = model.carName
            parkAnotherButton.isHidden = true
        }
        parkingTimerView.bind(model.timerText)
    }
    
    func updateTimerTime(timeString: String) {
        let textAttributedString = NSMutableAttributedString(string: "")
        let asterix = NSAttributedString(string: "\(timeString)c", attributes: [.foregroundColor: UIColor.mainBlue])
        textAttributedString.append(asterix)
        parkingTimerView.setTime(textAttributedString)
    }
}
