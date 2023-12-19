//
//  ProfileViewSettingsCell.swift
//  TuraqApp
//
//  Created by Akyl on 01.03.2023.
//

import UIKit

protocol ProfileViewSettingsCellDelegate: AnyObject {
    func profileViewSettingsCell(_ cell: ProfileViewSettingsCell, switchValueDidChange isOn: Bool, type: ProfileModels.SettingsCell.SettingsType)
}

final class ProfileViewSettingsCell: UITableViewCell, ReusableCell {
    
    // MARK: - Public Properties
    
        weak var delegate: ProfileViewSettingsCellDelegate?
    
    // MARK: - Private Properties
    
    private lazy var accessoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "next_icon")
        imageView.contentMode = .center
        
        return imageView
    }()
    
    private lazy var leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.tintColor = UIColor.mainBlue
        
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mainBlue
        label.font = UIFont(name: "NunitoSans-Regular", size: 16)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        
        return label
    }()
    
    private(set) lazy var switchView: UISwitch = {
        let switchView = UISwitch()
        switchView.onTintColor = UIColor.middleBlue
        switchView.addTarget(self, action: #selector(switchValueDidChange), for: .valueChanged)
        switchView.set(width: 40, height: 24)
        
        return switchView
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.textGray.withAlphaComponent(0.5)
        
        return view
    }()
    
    private var settingType: ProfileModels.SettingsCell.SettingsType?
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Method
    
    func bind(with model: ProfileModels.SettingsCell.Params) {
        settingType = model.settingsType
        leftImageView.image = model.icon
        nameLabel.text = model.name
        switchView.isOn = model.isOn
        
        accessoryImageView.isHidden = !(model.settingsType == .language)
        switchView.isHidden = (model.settingsType == .language)
        selectionStyle = (model.settingsType == .language) ? .default : .none
        
        separatorView.isHidden = model.settingsType == .location
    }
}

// MARK: - Actions

private extension ProfileViewSettingsCell {
    
    @objc
    func switchValueDidChange(_ sender: UISwitch) {
        guard let settingType else {
            return
        }
        delegate?.profileViewSettingsCell(self, switchValueDidChange: sender.isOn, type: settingType)
    }
}

// MARK: - Private

private extension ProfileViewSettingsCell {
    
    func setup() {
        setupLeftImageView()
        setupNameLabel()
        setupAccessoryImageView()
        setupSwitchView()
        setupSeparatorView()
    }
    
    func setupLeftImageView() {
        contentView.addSubview(leftImageView)
        leftImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }
    }
    
    func setupNameLabel() {
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(leftImageView.snp.trailing).offset(16)
            make.top.equalToSuperview().offset(16)
            make.bottom.lessThanOrEqualToSuperview().offset(-16)
            make.trailing.equalToSuperview().offset(-64)
        }
    }
    
    func setupAccessoryImageView() {
        contentView.addSubview(accessoryImageView)
        accessoryImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
    }
    
    func setupSwitchView() {
        contentView.addSubview(switchView)
        switchView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
    }
    
    func setupSeparatorView() {
        contentView.addSubview(separatorView)
        separatorView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
            make.height.equalTo(0.5)
            make.bottom.equalToSuperview()
        }
    }
}

