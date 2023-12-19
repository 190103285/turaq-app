//
//  UIImage+Extensions.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 29.03.2023.
//

import UIKit

public extension UIImage {

    convenience init(color: UIColor) {
        let rect = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)

        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()

        context?.setFillColor(color.cgColor)
        context?.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        if let cgImage = image?.cgImage {
            self.init(cgImage: cgImage)
        } else {
            assertionFailure("Can't create an image")
            self.init()
        }
    }
}
