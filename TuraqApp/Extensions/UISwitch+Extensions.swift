//
//  UISwitch+Extensions.swift
//  TuraqApp
//
//  Created by Akyl on 05.03.2023.
//

import Foundation
import UIKit

extension UISwitch {

    func set(width: CGFloat, height: CGFloat) {

        let standardHeight: CGFloat = 31
        let standardWidth: CGFloat = 51

        let heightRatio = height / standardHeight
        let widthRatio = width / standardWidth

        transform = CGAffineTransform(scaleX: widthRatio, y: heightRatio)
    }
}
