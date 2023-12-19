//
//  MyCarsViewCell.swift
//  TuraqApp
//
//  Created by Akyl on 05.03.2023.
//

import UIKit

final class MyCarsViewCell: UITableViewCell, ReusableCell {
    
    struct Params {
        let id: Int
        let regionalNumber: String
        let carName: String
        let isSelected: Bool
    }
    
    // MARK: - Private Properties
    
    private(set) lazy var checkbox: Checkbox = {
        let button = Checkbox()
//        button.addTarget(self, action: #selector(checkboxTap), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private lazy var carNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-Regular", size: 16)
        label.textColor = UIColor.mainBlue
        
        return label
    }()
    
    private lazy var regionalNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-Regular", size: 12)
        label.textColor = UIColor.textGray
        
        return label
    }()
    
    private(set) lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.textGray.withAlphaComponent(0.5)
        
        return view
    }()
    
    override var isSelected: Bool {
        didSet {
            updateForSelected(isSelected)
        }
    }
    
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

    func bind(with model: Params) {
        carNameLabel.text = model.carName
        regionalNumberLabel.text = model.regionalNumber
    }
    
    func updateForSelected(_ isSelected: Bool) {
        checkbox.isSelected = isSelected
    }
}

// MARK: - Private Methods

private extension MyCarsViewCell {
    
    func setup() {
        selectionStyle = .none
        setupSubviews()
    }
    
    func setupSubviews() {
        contentView.addSubview(checkbox)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(carNameLabel)
        stackView.addArrangedSubview(regionalNumberLabel)
        contentView.addSubview(separatorView)
        
        checkbox.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(16)
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(checkbox.snp.trailing).offset(24)
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-14)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        separatorView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
}


