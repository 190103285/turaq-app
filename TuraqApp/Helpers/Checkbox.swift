//
//  Checkbox.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 29.03.2023.
//

import UIKit

final class Checkbox: UIButton {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overrides
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !isUserInteractionEnabled || isHidden || alpha <= 0.01 {
            return nil
        }
     
        let touchRect = bounds.insetBy(dx: -10, dy: -10)
        if touchRect.contains(point) {
            for subview in subviews.reversed() {
                let convertedPoint = subview.convert(point, from: self)
                if let hitTestView = subview.hitTest(convertedPoint, with: event) {
                    return hitTestView
                }
            }
            return self
        }
        return nil
    }
    
    // MARK: - Public Methods
    
    func toggle() {
        isSelected.toggle()
        if isSelected {
            layer.borderWidth = 0
        } else {
            layer.borderWidth = 0.5
        }
    }
}

// MARK: - Private

private extension Checkbox {
    
    func setup() {
        isSelected = false
        backgroundColor = .clear
        layer.cornerRadius = 2
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.textGray.cgColor
        setImage(UIImage(named: "checkbox_icon"), for: .selected)
        setImage(nil, for: .normal)
        setBackgroundImage(UIImage(color: UIColor.middleBlue), for: .selected)
        setBackgroundImage(UIImage(color: .clear), for: .normal)
    }
}
