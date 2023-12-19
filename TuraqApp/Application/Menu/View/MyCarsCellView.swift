//
//  MyCarsCellView.swift
//  TuraqApp
//
//  Created by Akyl on 12.03.2023.
//

import UIKit
import SnapKit

protocol MyCarsCellViewDelegate: AnyObject {
    func didTapMyCars()
}

final class MyCarsCellView: HighlightView {
    
    weak var delegate: MyCarsCellViewDelegate?
    
    // MARK: - Views
    
    private lazy var gestureRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        return recognizer
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-Semibold", size: 16)
        label.textColor = UIColor.textGray
        label.textAlignment = .left
        label.text = "My Cars".localized()
        
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-Semibold", size: 16)
        label.textColor = UIColor.mainBlue
        label.textAlignment = .left
        label.text = "KZ327ACB10 AUDI A6"
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "next_icon")
        
        return imageView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(with model: CarModel) {
        subtitleLabel.text = "\(model.regionalNumber) \(model.brand) \(model.model)"
    }
    
    @objc
    func didTap(_ recognizer: UIGestureRecognizer) {
        delegate?.didTapMyCars()
    }
    
    // MARK: - Internal Methods
    
    
    // MARK: - Private Methods
    
    private func configure() {
        backgroundColor = .white
        isUserInteractionEnabled = true
        setupTitleLabel()
        setupSubtitleLabel()
        setupIconImageView()
        addGestureRecognizer(gestureRecognizer)
    }
    
    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
        }
    }
    
    func setupSubtitleLabel() {
        addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.trailing.lessThanOrEqualToSuperview().offset(-32)
            make.leading.equalToSuperview().offset(16)
        }
    }
    
    func setupIconImageView() {
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-9)
            make.size.equalTo(24)
        }
    }
}
