//
//  UIView+Extensions.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 29.03.2023.
//

import UIKit

public enum VerticalLocation: String {
    case bottom
    case top
}

public extension UIView {
    
    func addShadow(location: VerticalLocation,
                   color: UIColor = .white,
                   shadowOpacity: Float = 0.9,
                   shadowRadius: CGFloat = 5.0,
                   height: CGFloat = 5.0,
                   width: CGFloat = 0)
    {
        switch location {
        case .bottom:
            addShadow(offset: CGSize(width: width, height: height), color: color, shadowOpacity: shadowOpacity, shadowRadius: shadowRadius)
            
        case .top:
            addShadow(offset: CGSize(width: width, height: -height), color: color, shadowOpacity: shadowOpacity, shadowRadius: shadowRadius)
        }
    }
    
    func addShadow(offset: CGSize, color: UIColor = .white, shadowOpacity: Float = 0.5, shadowRadius: CGFloat = 5.0) {
        let view = self
        
        view.layer.masksToBounds = false
        view.layer.shadowColor = color.cgColor
        view.layer.shadowOffset = offset
        view.layer.shadowRadius = shadowRadius
        view.layer.shadowOpacity = shadowOpacity
    }
}
