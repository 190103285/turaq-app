//  Created by Akyl on 01.03.2023.

import UIKit

final class ProfileHeaderView: UIView {
    
    // MARK: - Private Properties

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-Bold", size: 24)
        label.textColor = UIColor.mainBlue
        
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Method

    func bind(with title: String) {
        titleLabel.text = title
    }
}

// MARK: - Private

private extension ProfileHeaderView {
    
    func setup() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(32)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
}

