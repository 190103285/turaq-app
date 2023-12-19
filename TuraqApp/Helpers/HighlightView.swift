//
//  HighlightView.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 02.05.2023.
//

import UIKit

private enum Constants {
    static let animationDuration: TimeInterval = 0.1
}

open class HighlightView: UIView {
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isUserInteractionEnabled else {
            return
        }
        alpha = 1.0
        UIView.animate(withDuration: Constants.animationDuration, delay: 0.0, options: .curveLinear, animations: {
            self.alpha = 0.5
        }, completion: nil)
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        alpha = 0.5
        UIView.animate(withDuration: Constants.animationDuration, delay: 0.0, options: .curveLinear, animations: {
            self.alpha = 1.0
        }, completion: nil)
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        alpha = 0.5
        UIView.animate(withDuration: Constants.animationDuration, delay: 0.0, options: .curveLinear, animations: {
            self.alpha = 1.0
        }, completion: nil)
    }
}
