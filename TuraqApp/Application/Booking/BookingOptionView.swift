//
//  BookingOptionView.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 02.05.2023.
//

import UIKit

protocol BookingOptionViewDelegate: AnyObject {
    func bookingOptionViewDidSelect(_ view: BookingOptionView, type: BookingOptionView.BookType)
}

final class BookingOptionView: HighlightView {
    
    enum BookType {
        case free
        case paid
    }
    
    weak var delegate: BookingOptionViewDelegate?
    
    private lazy var gestureRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        return recognizer
    }()
    
    private lazy var bookingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NunitoSans-Bold", size: 16)
        label.textColor = UIColor.mainBlue
        label.textAlignment = .center
        
        return label
    }()
    
    private(set) lazy var checkbox: Checkbox = Checkbox()
    
    private var type: BookType
    
    // MARK: - Init
    
    init(type: BookType) {
        self.type = type
        super.init(frame: .zero)
        
        setup()
        configureView(with: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    @objc
    private func didTap(_ recognizer: UIGestureRecognizer) {
        delegate?.bookingOptionViewDidSelect(self, type: type)
    }
    
    private func configureView(with type: BookType) {
        bookingLabel.text = type == .free ? "10 мин" : "1 час"
    }
}

private extension BookingOptionView {
    
    func setup() {
        addGestureRecognizer(gestureRecognizer)
        
        addSubview(checkbox)
        checkbox.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(16)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        addSubview(bookingLabel)
        bookingLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkbox.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
        }
    }
}
