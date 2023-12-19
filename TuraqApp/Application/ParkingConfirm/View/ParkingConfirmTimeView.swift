//
//  ParkingConfirmTimeView.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 16.04.2023.
//

import UIKit

protocol ParkingConfirmTimeViewDelegate: AnyObject {
    func didUpdateTime(_ startTime: Date, _ endTime: Date)
}

final class ParkingConfirmTimeView: UIView {
    
    weak var delegate: ParkingConfirmTimeViewDelegate?
        
    // MARK: - Views
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-Regular", size: 16)
        label.textColor = UIColor.textGray
        label.textAlignment = .center
        label.text = "Time".localized()
        
        return label
    }()
    
    private lazy var startTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-Regular", size: 16)
        label.textColor = .mainBlue
        label.textAlignment = .center
        label.text = "From".localized()
        
        return label
    }()
    
    private lazy var startTimeTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 8
        textField.translatesAutoresizingMaskIntoConstraints = true
        textField.textColor = .mainBlue
        textField.tintColor = .clear
        textField.font = UIFont(name: "NunitoSans-SemiBold", size: 16)
        textField.textAlignment = .center
        textField.backgroundColor = .white
        textField.inputView = startDatePicker
        textField.text = Formatter.formattedDateTime(date: Date())
        
        textField.rightViewMode = .always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        let image = UIImage(named: "more_button_icon")
        imageView.image = image
        textField.rightView = imageView
        
        return textField
    }()
    
    private lazy var endTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-Regular", size: 16)
        label.textColor = .mainBlue
        label.textAlignment = .center
        label.text = "To".localized()
        
        return label
    }()
    
    private lazy var endTimeTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 8
        textField.translatesAutoresizingMaskIntoConstraints = true
        textField.textColor = .mainBlue
        textField.tintColor = .clear
        textField.font = UIFont(name: "NunitoSans-SemiBold", size: 16)
        textField.textAlignment = .center
        textField.backgroundColor = .white
        textField.inputView = endDatePicker
        textField.text = Formatter.formattedDateTime(date: Date(timeIntervalSinceNow: 3600))
        
        textField.rightViewMode = .always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        let image = UIImage(named: "more_button_icon")
        imageView.image = image
        textField.rightView = imageView
        
        return textField
    }()
    
    private lazy var startDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.minimumDate = Date()
        datePicker.maximumDate = Date(timeIntervalSinceNow: 300)
        datePicker.addTarget(self, action: #selector(startTimeChanged(datePicker: )), for: .valueChanged)
        
        return datePicker
    }()
    
    private lazy var endDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.minimumDate = Date().addingTimeInterval(3600)
        datePicker.maximumDate = Date().addingTimeInterval(21600)
        datePicker.addTarget(self, action: #selector(endTimeChanged(datePicker: )), for: .valueChanged)
        
        return datePicker
    }()
    
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

private extension ParkingConfirmTimeView {
    
    func configure() {
        isUserInteractionEnabled = true
        
        addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        addSubview(startTimeLabel)
        startTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview()
        }
        
        addSubview(startTimeTextField)
        startTimeTextField.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(4)
            make.leading.equalTo(startTimeLabel.snp.trailing).offset(8)
            make.height.equalTo(36)
            make.width.equalTo(95)
        }
        
        addSubview(endTimeLabel)
        endTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(10)
            make.leading.equalTo(startTimeTextField.snp.trailing).offset(32)
        }
        
        addSubview(endTimeTextField)
        endTimeTextField.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(4)
            make.leading.equalTo(endTimeLabel.snp.trailing).offset(8)
            make.height.equalTo(36)
            make.width.equalTo(95)
            make.trailing.equalToSuperview()
        }
    }
}

// MARK: - Actions

private extension ParkingConfirmTimeView {
    
    @objc
    func startTimeChanged(datePicker: UIDatePicker) {
        startTime = datePicker.date
        startTimeTextField.text = Formatter.formattedDateTime(date: datePicker.date)
        delegate?.didUpdateTime(datePicker.date, endTime)
    }
    
    @objc
    func endTimeChanged(datePicker: UIDatePicker) {
        endTime = datePicker.date
        endTimeTextField.text = Formatter.formattedDateTime(date: datePicker.date)
        delegate?.didUpdateTime(startTime, datePicker.date)
    }
}
