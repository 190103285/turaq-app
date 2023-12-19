//
//  AddCarView.swift
//  TuraqApp
//
//  Created by Akyl on 10.03.2023.
//

import SnapKit
import UIKit

protocol AddCarViewLogic: UIView {
    
}

protocol AddCarViewDelegate: AnyObject {
    func validateCar(_ request: AddCarModels.AddCar.Request)
}

final class AddCarView: UIView {
    
    weak var delegate: AddCarViewDelegate?
    
    // MARK: - Views
    
    private lazy var gestureRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        return recognizer
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.bounces = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .clear
        
        return view
    }()
    
    private(set) lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "addCar_icon")
        
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mainBlue
        label.font = UIFont(name: "NunitoSans-Bold", size: 32)
        label.textAlignment = .left
        label.text = "Your car".localized()
        
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textGray
        label.font = UIFont(name: "NunitoSans-Regular", size: 16)
        label.textAlignment = .left
        label.text = "Enter transport details".localized()
        
        return label
    }()
    
    private lazy var regNumberTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor.mainBlue
        textField.font = UIFont(name: "NunitoSans-Regular", size: 16)
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .background
        textField.layer.cornerRadius = 8
        textField.autocapitalizationType = .allCharacters
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var brandTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor.mainBlue
        textField.font = UIFont(name: "NunitoSans-Regular", size: 16)
        textField.placeholder = "Car brand".localized()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .background
        textField.layer.cornerRadius = 8
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var modelTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor.mainBlue
        textField.font = UIFont(name: "NunitoSans-Regular", size: 16)
        textField.placeholder = "Car model".localized()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .background
        textField.layer.cornerRadius = 8
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.disabledGray
        button.setTitle("Add".localized(), for: [])
        button.titleLabel?.font = UIFont(name: "NunitoSans-Regular", size: 16)
        button.layer.cornerRadius = 8
        button.setTitleColor(UIColor.textGray, for: .disabled)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(addButtonTap), for: .touchUpInside)
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
    
    private func enableAddButton() {
        addButton.isEnabled = true
        addButton.backgroundColor = .mainBlue
    }
}

// MARK: - Actions

private extension AddCarView {
    
    @objc
    func addButtonTap() {
        let request = AddCarModels.AddCar.Request(
            regNumber: regNumberTextField.text ?? "",
            brand: brandTextField.text ?? "",
            model: modelTextField.text ?? ""
        )
        delegate?.validateCar(request)
    }
    
    @objc
    func didTap(_ recognizer: UIGestureRecognizer) {
        endEditing(true)
    }
    
    @objc
    func textFieldDidChange(_ textField: UITextField) {
        if let regNumber = regNumberTextField.text,
           let brand = brandTextField.text,
           let model = modelTextField.text {
            if !regNumber.isEmpty && !brand.isEmpty && !model.isEmpty {
                enableAddButton()
            }
        }
    }
}

// MARK: - Private Methods

private extension AddCarView {
    
    func configure() {
        backgroundColor = .background
        addGestureRecognizer(gestureRecognizer)
        setupScrollView()
        setupImageView()
        setupTitleLabel()
        setupSubtitleLabel()
        setupRegNumberTextField()
        setupBrandTextField()
        setupModelTextField()
        setupAddButton()
    }
    
    func setupScrollView() {
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.safeAreaLayoutGuide)
            make.left.right.centerX.equalToSuperview()
        }
    }
    
    func setupImageView() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(16)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(31)
            make.leading.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupSubtitleLabel() {
        addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupRegNumberTextField() {
        addSubview(regNumberTextField)
        regNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        let textAttributedString = NSMutableAttributedString(string: "Car number ".localized())
        let asterix = NSAttributedString(string: "*", attributes: [.foregroundColor: UIColor.error])
        textAttributedString.append(asterix)
        regNumberTextField.attributedPlaceholder = textAttributedString
    }
    
    func setupBrandTextField() {
        addSubview(brandTextField)
        brandTextField.snp.makeConstraints { make in
            make.top.equalTo(regNumberTextField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
    }
    
    func setupModelTextField() {
        addSubview(modelTextField)
        modelTextField.snp.makeConstraints { make in
            make.top.equalTo(brandTextField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
    }
    
    func setupAddButton() {
        addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.top.equalTo(modelTextField.snp.bottom).offset(80)
            make.leading.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.centerX.equalToSuperview()
            make.height.equalTo(48)
        }
    }
}

extension AddCarView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        return true
    }
    
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case self.regNumberTextField:
            self.brandTextField.becomeFirstResponder()
        case self.brandTextField:
            self.modelTextField.becomeFirstResponder()
        default:
            self.modelTextField.resignFirstResponder()
        }
    }
}

// MARK: - AddCarViewLogic

extension AddCarView: AddCarViewLogic {
    
}
