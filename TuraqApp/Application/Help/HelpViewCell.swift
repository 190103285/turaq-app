//
//  HelpViewCell.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 24.04.2023.
//

import UIKit

final class HelpViewCell: UITableViewCell, ReusableCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-SemiBold", size: 16)
        label.textColor = UIColor.mainBlue
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var accessoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "next_icon")
        
        return imageView
    }()
    
    private(set) lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.textGray.withAlphaComponent(0.5)
        
        return view
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(with title: String) {
        titleLabel.text = title
    }
}

// MARK: - Private Methods

private extension HelpViewCell {
    
    func setup() {
        setupTitleLabel()
        setupAccessoryImageView()
        setupSeparator()
    }
    
    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(21)
            make.bottom.equalToSuperview().offset(-21)
        }
    }
    
    func setupAccessoryImageView() {
        addSubview(accessoryImageView)
        accessoryImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    func setupSeparator() {
        addSubview(separatorView)
        separatorView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
}
