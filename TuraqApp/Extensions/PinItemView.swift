//
//  PinItemView.swift
//  TuraqApp
//
//  Created by Akyl on 27.02.2023.
//

import UIKit

protocol PinEntryItemViewDelegate: AnyObject {
    func pinEntryItemViewDidTap(_ view: PinEntryItemView)
}

class PinEntryItemView: UIView {
    
    struct ColorParams {
        let borderColor: UIColor
        let titleColor: UIColor
    }
    
    struct ButtonParams {
        let font: UIFont
        let text: String
    }
    
    weak var delegate: PinEntryItemViewDelegate?
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.layer.cornerRadius = 8
        
        return stackView
    }()
    
    private var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: - Public
    
    func setTitle(_ title: String) {
        button.setTitle(title, for: [])
    }
    
    func update(with params: ColorParams) {
        stackView.backgroundColor = params.borderColor
        button.setTitleColor(params.titleColor, for: [])
    }
    
    func configure(with params: ButtonParams) {
        button.setTitle(params.text, for: [])
        button.titleLabel?.font = params.font
        button.addTarget(self, action: #selector(entryButtonTap(sender:)), for: .touchUpInside)
        stackView.addArrangedSubview(button)
    }
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        initView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initView() {
        setupStackView()
    }
    
    private func setupStackView() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: 48),
            stackView.widthAnchor.constraint(equalToConstant: 48),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: - Actions

    @objc
    private func entryButtonTap(sender: UIButton) {
        delegate?.pinEntryItemViewDidTap(self)
    }
}

