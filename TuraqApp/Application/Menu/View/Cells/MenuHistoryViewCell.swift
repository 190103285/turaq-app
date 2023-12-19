//
//  MenuHistoryViewCell.swift
//  TuraqApp
//
//  Created by Akyl on 12.03.2023.
//

import UIKit

final class MenuHistoryViewCell: UITableViewCell, ReusableCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mainBlue
        label.font = UIFont(name: "NunitoSans-Semibold", size: 16)
        label.text = "Parking History".localized()
        label.sizeToFit()
        
        return label
    }()
    
    private lazy var historyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.image = UIImage(named: "history_icon")
        
        return imageView
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
    
    // MARK: - Public Methods
}

// MARK: - Private Methods

private extension MenuHistoryViewCell {
    
    func setup() {
        setupTitleLabel()
        setupHistoryImageView()
        setupSkeleton()
    }
    
    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(21)
            make.bottom.equalToSuperview().offset(-21)
        }
    }
    
    func setupHistoryImageView() {
        addSubview(historyImageView)
        historyImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }
    }
    
    func setupSkeleton() {
        makeSkeletonable(self)
    }
}

