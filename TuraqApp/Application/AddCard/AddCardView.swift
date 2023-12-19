//
//  AddCardView.swift
//  TuraqApp
//
//  Created by Akyl on 10.03.2023.
//

import SnapKit
import UIKit

protocol AddCardViewLogic: UIView {
    
}

protocol AddCardViewDelegate: AnyObject {
    func validateCard(_ request: AddCardModels.AddCard.Request)
}

final class AddCardView: UIView {
    
    weak var delegate: AddCardViewDelegate?
    
    // MARK: - Views
    
    private(set) lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "addCard_icon")
        
        return image
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
        label.textColor = .mainBlue
        label.font = UIFont(name: "NunitoSans-Bold", size: 32)
        label.textAlignment = .left
        label.text = "Your card".localized()
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textGray
        label.font = UIFont(name: "NunitoSans-Regular", size: 16)
        label.textAlignment = .left
        label.text = "Enter your bank card details".localized()
        
        return label
    }()
    
    private lazy var cardNumberTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor.mainBlue
        textField.font = UIFont(name: "NunitoSans-Regular", size: 16)
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .background
        textField.layer.cornerRadius = 8
        textField.autocapitalizationType = .allCharacters
        textField.keyboardType = .numberPad
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fillEqually
        
        return view
    }()
    
    private lazy var expirationDateTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor.mainBlue
        textField.font = UIFont(name: "NunitoSans-Regular", size: 16)
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .background
        textField.keyboardType = .numberPad
        textField.layer.cornerRadius = 8
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var cvvTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor.mainBlue
        textField.font = UIFont(name: "NunitoSans-Regular", size: 16)
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .background
        textField.keyboardType = .numberPad
        textField.layer.cornerRadius = 8
        textField.isSecureTextEntry = true
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
    
    // MARK: - Private Methods
    
    private func validateFields() {
        let isEnabled = [cardNumberTextField.text, expirationDateTextField.text, cvvTextField.text].allSatisfy({ $0?.isEmpty == false})
        addButton.isEnabled = isEnabled
        addButton.backgroundColor = isEnabled ? .mainBlue : .disabledGray
    }
}

// MARK: - Actions

private extension AddCardView {
    
    @objc
    func addButtonTap() {
        let request = AddCardModels.AddCard.Request(
            cardId: cardNumberTextField.text ?? "",
            expirationDate: expirationDateTextField.text ?? "",
            cvv: cvvTextField.text ?? "")
        delegate?.validateCard(request)
    }
}

private extension AddCardView {
    
    func configure() {
        backgroundColor = .background
        setupScrollView()
        setupImageView()
        setupTitleLabel()
        setupSubtitleLabel()
        setupCardNumberTextField()
        setupStackView()
        setupExpirationTextField()
        setupCvvTextField()
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
            make.top.equalTo(imageView.snp.bottom).offset(29)
            make.leading.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupSubtitleLabel() {
        addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(7)
            make.leading.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupCardNumberTextField() {
        addSubview(cardNumberTextField)
        cardNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(35)
            make.leading.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        let textAttributedString = NSMutableAttributedString(string: "Card number ".localized())
        let asterix = NSAttributedString(string: "*", attributes: [.foregroundColor: UIColor.error])
        textAttributedString.append(asterix)
        cardNumberTextField.attributedPlaceholder = textAttributedString
    }
    
    func setupStackView() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(cardNumberTextField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
    }
    
    func setupExpirationTextField() {
        stackView.addArrangedSubview(expirationDateTextField)
        let textAttributedString = NSMutableAttributedString(string: "Expiration date ".localized())
        let asterix = NSAttributedString(string: "*", attributes: [.foregroundColor: UIColor.error])
        textAttributedString.append(asterix)
        expirationDateTextField.attributedPlaceholder = textAttributedString
    }
    
    func setupCvvTextField() {
        stackView.addArrangedSubview(cvvTextField)
        let textAttributedString = NSMutableAttributedString(string: "CVV ")
        let asterix = NSAttributedString(string: "*", attributes: [.foregroundColor: UIColor.error])
        textAttributedString.append(asterix)
        cvvTextField.attributedPlaceholder = textAttributedString
    }
    
    func setupAddButton() {
        addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(80)
            make.leading.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.centerX.equalToSuperview()
            make.height.equalTo(48)
        }
    }
}

extension AddCardView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        return true
    }
    
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case self.cardNumberTextField:
            self.expirationDateTextField.becomeFirstResponder()
        case self.expirationDateTextField:
            self.cvvTextField.becomeFirstResponder()
        default:
            self.cvvTextField.resignFirstResponder()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        var formattedString = ""
        if textField == cardNumberTextField {
            formattedString = Formatter.format(newString, pattern: Formatter.cardIdPattern)
        } else if textField == expirationDateTextField {
            formattedString = Formatter.format(newString, pattern: Formatter.expirationDatePattern)
        } else {
            formattedString = Formatter.format(newString, pattern: Formatter.cvvPattern)
        }
        textField.text = formattedString
        
        
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        validateFields()
    }
}

// MARK: - AddCardViewLogic

extension AddCardView: AddCardViewLogic {
    
}
