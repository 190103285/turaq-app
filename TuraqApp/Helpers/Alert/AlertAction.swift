//
//  AlertAction.swift
//  TuraqApp
//
//  Created by Akyl on 07.03.2023.
//

import UIKit

public class AlertAction: UIButton {
    private struct Constants {
        static let titleInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    public enum Style {
        case `default`
        case main
        case destructive
        
        var backgroundColor: UIColor {
            switch self {
            case .`default`:
                return .disabledGray
            case .main:
                return .mainBlue
            case .destructive:
                return .systemRed
            }
        }
        
        var tintColor: UIColor {
            switch self {
            case .`default`:
                return .mainBlue
            case .main, .destructive:
                return .white
            }
        }
        
        var font: UIFont {
            switch self {
            case .`default`, .destructive:
                return .systemFont(ofSize: 14, weight: .medium)
            case .main:
                return .systemFont(ofSize: 16)
            }
        }
    }
    
    // MARK: Private properties
    
    private var handler: ((AlertAction) -> Void)?
    
    private var style: Style
    
    private var title: String?
    
    public init(title: String?, style: Style, handler: ((AlertAction) -> Void)? = nil) {
        self.title = title
        self.style = style
        self.handler = handler
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public Methods
    
    public func buttonWidth() -> CGFloat {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: style.font
        ]
        let string = (title ?? "") as NSString
        let size = string.size(withAttributes: attributes)
        
        return size.width + Constants.titleInsets.left + Constants.titleInsets.right
    }
    
    public func performAction() {
        handler?(self)
    }
    
    // MARK: Private Methods
    
    private func setup() {
        setupStyle()
        
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(title, for: [])
    }
    
    private func setupStyle() {
        clipsToBounds = true
        layer.cornerRadius = 10
        backgroundColor = style.backgroundColor
        setTitleColor(style.tintColor, for: [])
        tintColor = style.tintColor
        titleLabel?.textColor = style.tintColor
        titleLabel?.font = style.font
        titleEdgeInsets = Constants.titleInsets
    }
}
