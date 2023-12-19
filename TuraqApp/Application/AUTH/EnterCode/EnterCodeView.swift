//
//  EnterCodeView.swift
//  TuraqApp
//
//  Created by Akyl on 27.02.2023.
//

import SnapKit
import UIKit

protocol EnterCodeViewLogic: UIView {
    func displayEnterCode(_ viewModel: EnterCodeModels.EnterCode.ViewModel)
    func showInvalidCode()
    func updateResendButton(isAvailable: Bool)
    func updateResendCodeTime(timeString: String)
}

protocol EnterCodeViewDelegate: AnyObject {
    func validateCode(_ code: String)
    func resendCode()
}

final class EnterCodeView: UIView {
    
    weak var delegate: EnterCodeViewDelegate?
    
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
        label.text = "Код верификации"
        
        return label
    }()
    
    private(set) lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-Regular", size: 16)
        label.textColor = UIColor.textGray
        label.numberOfLines = 0
        
        return label
    }()
    
    private(set) lazy var pinEntryView: PinEntryView = {
        let view = PinEntryView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.entryFieldsTitleColor = UIColor.mainBlue
        view.selectedEntryFieldsTitleColor = UIColor.mainBlue
        view.selectedEntryFieldsBorderColor = UIColor.disabledGray
        view.entryFieldsBorderColor = UIColor.disabledGray
        view.delegate = self
        view.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        return view
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-Regular", size: 16)
        label.textColor = UIColor.error
        label.text = "Неверный код"
        label.isHidden = true
        
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
    
    private lazy var resendCodeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.disabledGray
        button.setTitle("Не получил код", for: [])
        button.titleLabel?.font = UIFont(name: "NunitoSans-Regular", size: 16)
        button.setTitleColor(.mainBlue, for: .normal)
        button.setTitleColor(.textGray, for: .disabled)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(resendCodeDidTap), for: .touchUpInside)
        button.isEnabled = false
        
        return button
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.mainBlue
        button.setTitle("Далее", for: [])
        button.titleLabel?.font = UIFont(name: "NunitoSans-Regular", size: 16)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(continueDidTap), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var resendСodeTimerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-Regular", size: 16)
        label.textColor = UIColor.textGray
        label.numberOfLines = 1
        
        return label
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
    
    func updateResendCodeTime(timeString: String) {
        let textAttributedString = NSMutableAttributedString(string: "Отправить снова через ")
        let asterix = NSAttributedString(string: "\(timeString)c", attributes: [.foregroundColor: UIColor.middleBlue])
        textAttributedString.append(asterix)
        resendСodeTimerLabel.attributedText = textAttributedString
    }
    
    func updateResendButton(isAvailable: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.resendCodeButton.isEnabled = isAvailable
            self.resendСodeTimerLabel.alpha = isAvailable ? 0 : 1
        }
    }
}

// MARK: - Private Properties

private extension EnterCodeView {
    
    func updateContinueButton(_ isEnabled: Bool) {
        continueButton.isEnabled = isEnabled
    }
    
    
    func updateEntryView(_ isError: Bool) {
        pinEntryView.entryFieldsTitleColor = isError ? .error : .mainBlue
        pinEntryView.selectedEntryFieldsTitleColor = isError ? .error : .mainBlue
    }
    
    func updateErrorLabel(_ isVisible: Bool) {
        errorLabel.isHidden = !isVisible
    }
}

// MARK: - Actions

private extension EnterCodeView {
    
    @objc
    func didTap(_ recognizer: UIGestureRecognizer) {
        endEditing(true)
    }
    
    @objc
    func textFieldDidChange(_ textField: UITextField) {
        updateEntryView(false)
        updateErrorLabel(false)
    }
    
    @objc
    func resendCodeDidTap() {
        updateEntryView(false)
        updateErrorLabel(false)
        resendCodeButton.setTitle("Отправить снова", for: [])
        delegate?.resendCode()
    }
    
    @objc
    func continueDidTap() {
        if let code = pinEntryView.textField.text {
            delegate?.validateCode(code)
        }
    }
}

// MARK: - Setup UI

private extension EnterCodeView {
    
    func configure() {
        backgroundColor = .background
        addGestureRecognizer(gestureRecognizer)
        setupScrollView()
        setupTitleLabel()
        setupSubtitleLabel()
        setupPinEntryView()
        setupErrorLabel()
        setupButtonStackView()
        setupResendCodeButton()
        setupContinueButton()
        setupResendCodeTimeLabel()
    }
    
    func setupScrollView() {
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.verticalEdges.equalToSuperview()
            make.centerX.equalToSuperview()
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
    
    func setupSubtitleLabel() {
        scrollView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupPinEntryView() {
        scrollView.addSubview(pinEntryView)
        pinEntryView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupErrorLabel() {
        scrollView.addSubview(errorLabel)
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(pinEntryView.snp.bottom).offset(8)
            make.centerX.equalTo(pinEntryView.snp.centerX)
        }
    }
    
    func setupButtonStackView() {
        scrollView.addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(errorLabel.snp.bottom).offset(18)
            make.leading.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupResendCodeButton() {
        buttonStackView.addArrangedSubview(resendCodeButton)
        resendCodeButton.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
    }
    
    func setupContinueButton() {
        buttonStackView.addArrangedSubview(continueButton)
        continueButton.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
    }
    
    func setupResendCodeTimeLabel() {
        scrollView.addSubview(resendСodeTimerLabel)
        resendСodeTimerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(buttonStackView.snp.bottom).offset(32)
        }
    }
}

// MARK: - EnterCodeViewLogic

extension EnterCodeView: EnterCodeViewLogic {
    
    func displayEnterCode(_ viewModel: EnterCodeModels.EnterCode.ViewModel) {
        subtitleLabel.text = "Пожалуйста, введите код верификации, отправленный на \(viewModel.phoneNumber)."
    }
    
    func showInvalidCode() {
        updateEntryView(true)
        updateErrorLabel(true)
    }
}

// MARK: - PinEntryViewDelegate

extension EnterCodeView: PinEntryViewDelegate {
    
    func pinEntryView(_ view: PinEntryView, didUpdateCode code: String, isFinished: Bool) {
//        updateWrongCodeMessageVisibility(isVisible: false)
//
//        if isFinished {
//            delegate?.enterCodeView(self, didFinish: code)
//        }
    }
}

// MARK: - UITextFieldDelegate

extension EnterCodeView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
