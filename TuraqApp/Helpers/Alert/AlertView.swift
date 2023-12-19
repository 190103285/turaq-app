//
//  AlertView.swift
//  TuraqApp
//
//  Created by Akyl on 07.03.2023.
//

import UIKit

class AlertView: UIView {
    
    private struct Constants {
        static let containerInsets = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
        static let actionButtonHeight: CGFloat = 40
        static let buttonsSpacing: CGFloat = 10
        static let mainStackSpacing: CGFloat = 10
        static let titleFont = UIFont.systemFont(ofSize: 18, weight: .semibold)
        static let titleTextColor = UIColor.mainBlue
        static let messageFont = UIFont.systemFont(ofSize: 16)
        static let messageTextColor = UIColor.mainBlue
        static let containerCornerRadius: CGFloat = 10
        static let containerBackgroundColor = UIColor.white
        static let containerShadowColor = UIColor(red: 0.294, green: 0.275, blue: 0.588, alpha: 0.1)
        static let containerShadowOpacity: Float = 1
        static let containerShadowRadius: CGFloat = 15
        static let containerShadowOffset: CGSize = .zero
    }
    
    // MARK: UI Elements
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Constants.containerBackgroundColor
        view.layer.cornerRadius = Constants.containerCornerRadius
        view.layer.shadowColor = Constants.containerShadowColor.cgColor
        view.layer.shadowOpacity = Constants.containerShadowOpacity
        view.layer.shadowRadius = Constants.containerShadowRadius
        view.layer.shadowOffset = Constants.containerShadowOffset
        
        return view
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Constants.mainStackSpacing
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private lazy var imageContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .center
        view.setContentHuggingPriority(.init(rawValue: 257), for: .vertical)
        view.setContentCompressionResistancePriority(.init(rawValue: 757), for: .vertical)
        
        return view
    }()
    
    private lazy var labelsScrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alwaysBounceVertical = false
        
        return view
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Constants.mainStackSpacing
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = Constants.titleFont
        label.textColor = Constants.titleTextColor
        label.setContentHuggingPriority(.init(rawValue: 256), for: .vertical)
        label.setContentCompressionResistancePriority(.init(rawValue: 756), for: .vertical)
        
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.init(rawValue: 255), for: .vertical)
        label.setContentCompressionResistancePriority(.init(rawValue: 755), for: .vertical)
        label.textAlignment = .center
        label.textColor = Constants.messageTextColor
        label.font = Constants.messageFont
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var buttonsContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Constants.buttonsSpacing
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private var actions = [AlertAction]()
    
    // MARK: Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setContainerWidthConstraint()
        setButtonsStackOrientation()
        super.layoutSubviews()
    }
    
    // MARK: Private Methods
    
    private func setup() {
        setupSubviews()
        
        backgroundColor = UIColor.black.withAlphaComponent(0.25)
    }
    
    private func setupSubviews() {
        addSubview(containerView)
        containerView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(imageContainer)
        imageContainer.addSubview(imageView)
        mainStackView.addArrangedSubview(labelsScrollView)
        labelsScrollView.addSubview(labelsStackView)
        labelsStackView.addArrangedSubview(titleLabel)
        labelsStackView.addArrangedSubview(messageLabel)
        mainStackView.addArrangedSubview(buttonsContainer)
        buttonsContainer.addSubview(buttonsStackView)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: Constants.containerInsets.top)
        ])
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            mainStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: imageContainer.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: -15)
        ])
        
        let scrollViewHeightConstraint = labelsStackView.heightAnchor.constraint(equalTo: labelsScrollView.heightAnchor)
        scrollViewHeightConstraint.priority = .init(rawValue: 254)
        
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: labelsScrollView.topAnchor),
            labelsStackView.leadingAnchor.constraint(equalTo: labelsScrollView.leadingAnchor),
            labelsStackView.trailingAnchor.constraint(equalTo: labelsScrollView.trailingAnchor),
            labelsStackView.bottomAnchor.constraint(equalTo: labelsScrollView.bottomAnchor),
            labelsStackView.widthAnchor.constraint(equalTo: labelsScrollView.widthAnchor),
            scrollViewHeightConstraint
        ])
        
        NSLayoutConstraint.activate([
            buttonsStackView.topAnchor.constraint(equalTo: buttonsContainer.topAnchor, constant: 20),
            buttonsStackView.leadingAnchor.constraint(equalTo: buttonsContainer.leadingAnchor),
            buttonsStackView.trailingAnchor.constraint(equalTo: buttonsContainer.trailingAnchor),
            buttonsStackView.bottomAnchor.constraint(equalTo: buttonsContainer.bottomAnchor)
        ])
    }
    
    private func setContainerWidthConstraint() {
        let width = min(325, bounds.width - Constants.containerInsets.left - Constants.containerInsets.right)
        
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: width)
        ])
    }
    
    private func setButtonsStackOrientation() {
        let isHasCollision = actions.contains {
            let width = $0.bounds.width
            return width > 0 && $0.buttonWidth() > width
        }
        buttonsStackView.axis = isHasCollision ? .vertical : .horizontal
    }
    
    // MARK: Public Methods
    
    func setTitle(_ title: String?) {
        titleLabel.text = title ?? ""
        titleLabel.isHidden = title?.isEmpty ?? true
        labelsScrollView.isHidden = !labelsStackView.arrangedSubviews.contains {
            !$0.isHidden
        }
    }
    
    func setMessage(_ message: String?) {
        messageLabel.text = message ?? ""
        messageLabel.isHidden = message?.isEmpty ?? true
        labelsScrollView.isHidden = !labelsStackView.arrangedSubviews.contains {
            !$0.isHidden
        }
    }
    
    func setImage(_ image: UIImage?) {
        imageView.image = image
        imageContainer.isHidden = image == nil
    }
    
    func setActions(_ actions: [AlertAction]) {
        self.actions = actions
        buttonsStackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
            buttonsStackView.removeArrangedSubview($0)
        }
        actions.forEach {
            buttonsStackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.heightAnchor.constraint(equalToConstant: Constants.actionButtonHeight).isActive = true
        }
        buttonsContainer.isHidden = buttonsStackView.arrangedSubviews.isEmpty
    }
}

