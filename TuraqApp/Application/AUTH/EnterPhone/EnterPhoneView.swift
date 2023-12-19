//
//  EnterPhoneView.swift
//  TuraqApp
//
//  Created by Akyl on 24.02.2023.
//

import SnapKit
import UIKit

protocol EnterPhoneViewDelegate: AnyObject {
    func getCodeButtonDidTap(with phoneNumber: String)
}

protocol EnterPhoneViewLogic: UIView {
    func showError()
}

final class EnterPhoneView: UIView {
    
    weak var delegate: EnterPhoneViewDelegate?
    
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
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-Bold", size: 32)
        label.textColor = UIColor.mainBlue
        label.text = "Вход"
        
        return label
    }()
    
    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-Regular", size: 16)
        label.textColor = UIColor.textGray
        label.text = "Номер телефона"
        
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor.textGray
        textField.font = UIFont(name: "NunitoSans-Regular", size: 20)
        textField.placeholder = "+7-777-777-77-77"
        textField.keyboardType = .numberPad
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var textFieldSeprator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.textGray
        
        return view
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-Regular", size: 12)
        label.textColor = UIColor.error
        label.text = "Пожайлуйста, введите свой действенный номер"
        label.numberOfLines = 0
        label.isHidden = true // TODO: IS HIDDEN
        
        return label
    }()
    
    private lazy var getCodeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.mainBlue
        button.setTitle("Получить код", for: [])
        button.titleLabel?.font = UIFont(name: "NunitoSans-Regular", size: 16)
        button.layer.cornerRadius = 8
        button.setTitleColor(UIColor.textGray, for: .disabled)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(getCodeButtonTap), for: .touchUpInside)
        button.isEnabled = false
        
        return button
    }()
    
    private(set) lazy var checkbox: Checkbox = {
        let button = Checkbox()
        button.addTarget(self, action: #selector(checkboxTap), for: .touchUpInside)
        
        return button
    }()
    
    private(set) lazy var rulesTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.backgroundColor = .background
        
        return textView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        configure()
        update(isGettingCodeAvailable: false)
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Update

private extension EnterPhoneView {
    
    func updateSeparatorBackgroundColor(_ isBeginEditing: Bool) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .transitionCrossDissolve) {
            self.textFieldSeprator.backgroundColor = isBeginEditing ? UIColor.mainBlue : UIColor.textGray
        }
    }
    
    func updateWrongPhoneNumberMessage(isVisible: Bool) {
        UIView.animate(withDuration: 0.5) {
            self.textFieldSeprator.backgroundColor = isVisible ? .error : .textGray
            self.errorLabel.isHidden = !isVisible
        }
    }
    
    func update(isGettingCodeAvailable: Bool) {
        getCodeButton.backgroundColor = isGettingCodeAvailable ? UIColor.mainBlue : UIColor.disabledGray
        getCodeButton.isEnabled = isGettingCodeAvailable
    }
    
    func configureRulesTextView() {
        let font = UIFont(name: "NunitoSans-Regular", size: 14)
        let text = "Я соглашаюсь с Политикой конфиденциальности и даю свое согласие на обработку персональных данных. "
        
        let attributesString = NSMutableAttributedString(string: text,
                                                         attributes: [.font: font, .foregroundColor: UIColor.textGray])
        
        var range = attributesString.mutableString.range(of: "Политикой конфиденциальности")
        attributesString.addAttributes([.link: URL(string: "https://moodle.sdu.edu.kz/login/index.php")], range: range)
        
        range = attributesString.mutableString.range(of: "обработку персональных данных")
        attributesString.addAttributes([.link:  URL(string: "https://oldmy.sdu.edu.kz")], range: range)
        
        let asterix = NSAttributedString(string: "*", attributes: [.foregroundColor: UIColor.error])
        attributesString.append(asterix)
        
        rulesTextView.attributedText = attributesString
        rulesTextView.textAlignment = .left
        rulesTextView.linkTextAttributes = [
            .foregroundColor: UIColor.middleBlue,
            .underlineColor: UIColor.middleBlue,
            .underlineStyle: NSUnderlineStyle.thick.rawValue
        ]
        rulesTextView.sizeToFit()
    }
}

// MARK: - Actions

private extension EnterPhoneView {
    
    @objc
    func getCodeButtonTap() {
        update(isGettingCodeAvailable: false)
        delegate?.getCodeButtonDidTap(with: textField.text ?? "")
    }
    
    @objc
    func didTap(_ recognizer: UIGestureRecognizer) {
        endEditing(true)
    }
    
    @objc
    func checkboxTap() {
        checkbox.toggle()
        if let text = textField.text {
            update(isGettingCodeAvailable: !text.isEmpty && checkbox.isSelected)
        }
    }
}

// MARK: - Private Methods

private extension EnterPhoneView {
    
    func configure() {
        backgroundColor = .background
        addGestureRecognizer(gestureRecognizer)
        setupScrollView()
        setupTitleLabel()
        setupPhoneNumberLabel()
        setupTextField()
        setupTextFieldSeparator()
        setupErrorLabel()
        setupGetCodeButton()
        setupCheckbox()
        setupRulesTextView()
    }
    
    func setupScrollView() {
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.safeAreaLayoutGuide)
            make.left.right.centerX.equalToSuperview()
        }
    }
    
    func setupTitleLabel() {
        scrollView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(160)
            make.leading.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupPhoneNumberLabel() {
        scrollView.addSubview(phoneNumberLabel)
        phoneNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupTextField() {
        scrollView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupTextFieldSeparator() {
        scrollView.addSubview(textFieldSeprator)
        textFieldSeprator.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(1)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupErrorLabel() {
        scrollView.addSubview(errorLabel)
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(textFieldSeprator.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupGetCodeButton() {
        scrollView.addSubview(getCodeButton)
        getCodeButton.snp.makeConstraints { make in
            make.top.equalTo(errorLabel.snp.bottom).offset(28)
            make.leading.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupCheckbox() {
        scrollView.addSubview(checkbox)
        checkbox.snp.makeConstraints { make in
            make.top.equalTo(getCodeButton.snp.bottom).offset(44)
            make.leading.equalToSuperview().offset(32)
            make.size.equalTo(16)
        }
    }
    
    func setupRulesTextView() {
        configureRulesTextView()
        scrollView.addSubview(rulesTextView)
        rulesTextView.snp.makeConstraints { make in
            make.top.equalTo(getCodeButton.snp.bottom).offset(32)
            make.leading.equalTo(checkbox.snp.trailing).offset(10)
            make.right.equalToSuperview().offset(-32)
        }
    }
}

// MARK: - UITextFieldDelegate

extension EnterPhoneView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.textColor = .mainBlue
        updateSeparatorBackgroundColor(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSeparatorBackgroundColor(false)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        let formattedString = Formatter.format(
            newString)
        textField.text = formattedString
        update(isGettingCodeAvailable: formattedString.count > 1 && checkbox.isSelected)
        updateWrongPhoneNumberMessage(isVisible: false)
        return false
    }
}

// MARK: - EnterPhoneViewLogic

extension EnterPhoneView: EnterPhoneViewLogic {
    
    func showError() {
        updateWrongPhoneNumberMessage(isVisible: true)
    }
}
