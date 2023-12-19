//
//  ParkingView.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 10.04.2023.
//

import SnapKit
import UIKit

protocol ParkingViewLogic: UIView {
    func bind(with model: MainFlow.Status.ParkingViewModel)
}

protocol ParkingViewDelegate: AnyObject {
    func bookButtonTap(_ id: Int)
    func parkButtonTap()
}

final class ParkingView: UIView {
    
    weak var delegate: ParkingViewDelegate?
    
    // MARK: - Views
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-Bold", size: 24)
        label.textColor = UIColor.mainBlue
        label.textAlignment = .center
        label.text = "Parking Information".localized()
        
        return label
    }()
    
    private lazy var parkingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.image = UIImage(named: "parking_image")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var addressContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    private lazy var addressStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private lazy var addressTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-SemiBold", size: 16)
        label.textColor = UIColor.textGray
        label.text = "Address".localized()
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var addressSubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-SemiBold", size: 16)
        label.textColor = UIColor.mainBlue
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var placesContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    private lazy var placesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private lazy var placesTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-SemiBold", size: 16)
        label.textColor = UIColor.textGray
        label.text = "Free Zones".localized()
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var placesSubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-SemiBold", size: 16)
        label.textColor = UIColor.mainBlue
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private lazy var parkButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.mainBlue
        button.setTitle("Park".localized(), for: [])
        button.titleLabel?.font = UIFont(name: "NunitoSans-Regular", size: 16)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(parkDidTap), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var bookButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.disabledGray
        button.setTitle("Book".localized(), for: [])
        button.titleLabel?.font = UIFont(name: "NunitoSans-Regular", size: 16)
        button.setTitleColor(.mainBlue, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(bookDidTap), for: .touchUpInside)
        
        return button
    }()
    
    var model: MainFlow.Status.ParkingViewModel?
    
    // MARK: - Init
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal Methods
    
    @objc
    func bookDidTap() {
        guard let model else {
            return
        }
        delegate?.bookButtonTap(model.parkingId)
    }
    
    @objc
    func parkDidTap() {
        delegate?.parkButtonTap()
    }
    
    // MARK: - Private Methods
}

private extension ParkingView {
    
    func configure() {
        backgroundColor = .background
        setupTitleLabel()
        setupParkingImageView()
        setupAddressContainerView()
        setupAddressStackView()
        setupPlacesContainerView()
        setupPlacesStackView()
        setupButtonStackView()
        setupParkButton()
        setupBookButton()
    }
    
    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
    }
    
    func setupParkingImageView() {
        addSubview(parkingImageView)
        parkingImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(titleLabel.snp.bottom).offset(32)
            make.height.equalTo(100)
        }
    }
    
    func setupAddressContainerView() {
        addSubview(addressContainerView)
        addressContainerView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(parkingImageView.snp.bottom).offset(16)
        }
    }
    
    func setupAddressStackView() {
        addressContainerView.addSubview(addressStackView)
        addressStackView.addArrangedSubview(addressTitleLabel)
        addressStackView.addArrangedSubview(addressSubtitleLabel)
        addressStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
    }
    
    func setupPlacesContainerView() {
        addSubview(placesContainerView)
        placesContainerView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(addressContainerView.snp.bottom).offset(16)
        }
    }
    
    func setupPlacesStackView() {
        placesContainerView.addSubview(placesStackView)
        placesStackView.addArrangedSubview(placesTitleLabel)
        placesStackView.addArrangedSubview(placesSubtitleLabel)
        placesStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
    }
    
    func setupButtonStackView() {
        addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(placesContainerView.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-8)
        }
    }
    
    func setupParkButton() {
        buttonStackView.addArrangedSubview(parkButton)
        parkButton.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
    }
    
    func setupBookButton() {
        buttonStackView.addArrangedSubview(bookButton)
        bookButton.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
    }
}

// MARK: - ParkingViewLogic

extension ParkingView: ParkingViewLogic {
    
    func bind(with model: MainFlow.Status.ParkingViewModel) {
        self.model = model
        addressSubtitleLabel.text = model.parkingName
        placesSubtitleLabel.text = String(model.emptyPlace)
    }
}
