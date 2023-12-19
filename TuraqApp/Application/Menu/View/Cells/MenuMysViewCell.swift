//
//  MenuMysViewCell.swift
//  TuraqApp
//
//  Created by Akyl on 12.03.2023.
//

import UIKit
import SnapKit

protocol MenuMysViewCellDelegate: AnyObject {
    func didTapMyCars()
    func didTapMyCards()
}

final class MenuMysViewCell: UITableViewCell, ReusableCell {
    
    weak var delegate: MenuMysViewCellDelegate?
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fillEqually
        
        return view
    }()
    
    private lazy var myCarsView: MyCarsCellView = {
        let view = MyCarsCellView()
        view.delegate = self
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    private lazy var myCardsView: MyCardsCellView = {
        let view = MyCardsCellView()
        view.delegate = self
        view.layer.cornerRadius = 8
        
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
    
    func bind(carModel: CarModel, cardModel: CardModel) {
        myCarsView.bind(with: carModel)
        myCardsView.bind(with: cardModel)
    }
    
    // MARK: - Public Methods
}

// MARK: - MyCarsCellViewDelegate

extension MenuMysViewCell: MyCarsCellViewDelegate {
    
    func didTapMyCars() {
        delegate?.didTapMyCars()
    }
}

// MARK: - MyCardsCellViewDelegate

extension MenuMysViewCell: MyCardsCellViewDelegate {
    
    func didTapMyCards() {
        delegate?.didTapMyCards()
    }
}

// MARK: - Private Methods

private extension MenuMysViewCell {
    
    func setup() {
        backgroundColor = .background
        contentView.isUserInteractionEnabled = true
        setupStackView()
        setupMyCarsView()
        setupMyCardsView()
        setupSkeleton()
    }
    
    func setupStackView() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.verticalEdges.equalToSuperview()
        }
    }
    
    func setupMyCarsView() {
        stackView.addArrangedSubview(myCarsView)
        myCarsView.snp.makeConstraints { make in
            make.height.equalTo(120)
        }
    }
    
    func setupMyCardsView() {
        stackView.addArrangedSubview(myCardsView)
        myCardsView.snp.makeConstraints { make in
            make.height.equalTo(120)
        }
    }
    
    func setupSkeleton() {
        makeSkeletonable(self)
    }
}
