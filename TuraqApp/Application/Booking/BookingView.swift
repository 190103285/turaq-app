//
//  BookingView.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 12.04.2023.
//

import SnapKit
import UIKit

protocol BookingViewLogic: UIView {
    
}

protocol BookingViewDelegate: AnyObject {
    func confirmDidTap(with type: BookingView.BookingType)
}

final class BookingView: UIView {
    
    enum BookingType {
        case free
        case paid
    }
    
    weak var delegate: BookingViewDelegate?
    
    // MARK: - Views
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-Bold", size: 24)
        label.textColor = UIColor.mainBlue
        label.textAlignment = .center
        label.text = "Attention".localized()
        
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-Regular", size: 16)
        label.textColor = UIColor.mainBlue
        label.textAlignment = .center
        label.text = "Select booking type".localized()
        
        return label
    }()
    
    private lazy var bookingContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    private lazy var bookingStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        
        return view
    }()
    
    private lazy var freeBookingView: BookingOptionView = {
        let view = BookingOptionView(type: .free)
        view.delegate = self
        
        return view
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.textGray.withAlphaComponent(0.5)
        
        return view
    }()
    
    private lazy var paidBookingView: BookingOptionView = {
        let view = BookingOptionView(type: .paid)
        view.delegate = self
        
        return view
    }()
    
    private lazy var totalPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-Regular", size: 12)
        label.textColor = UIColor.textGray
        label.textAlignment = .center
        label.isHidden = true
        
        return label
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.disabledGray
        button.setTitle("Confirm".localized(), for: [])
        button.titleLabel?.font = UIFont(name: "NunitoSans-Regular", size: 16)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(confirmButtonDidTap), for: .touchUpInside)
        button.setTitleColor(.textGray, for: .disabled)
        button.isEnabled = false
        
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func confirmButtonDidTap() {
        delegate?.confirmDidTap(with: freeBookingView.checkbox.isSelected ? .free : .paid)
    }
}

// MARK: - Private Methods

private extension BookingView {
    
    func configure() {
        backgroundColor = .background
        addSubviews()
    }
    
    func addSubviews() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.centerX.equalToSuperview()
        }
        
        addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.centerX.equalToSuperview()
        }
        
        addSubview(bookingContainerView)
        bookingContainerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(14)
        }
        
        bookingContainerView.addSubview(bookingStackView)
        bookingStackView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        bookingStackView.addArrangedSubview(freeBookingView)
        
        bookingStackView.addArrangedSubview(separatorView)
        separatorView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(0.5)
        }
        
        bookingStackView.addArrangedSubview(paidBookingView)
        
        addSubview(totalPriceLabel)
        totalPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(bookingContainerView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        addSubview(confirmButton)
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(totalPriceLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(132)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-32)
        }
    }
}

// MARK: - BookingViewLogic

extension BookingView: BookingViewLogic {}

// MARK: - BookingOptionViewDelegate

extension BookingView: BookingOptionViewDelegate {
    
    func bookingOptionViewDidSelect(_ view: BookingOptionView, type: BookingOptionView.BookType) {
        confirmButton.backgroundColor = .mainBlue
        confirmButton.isEnabled = true
        
        freeBookingView.checkbox.isSelected = type == .free
        paidBookingView.checkbox.isSelected = type == .paid
        
        totalPriceLabel.isHidden = false
        totalPriceLabel.text = "Cтоимость бронирования - \(type == .free ? "бесплатно" : "100 ₸")" // TODO: Localization
    }
}
