//
//  CustomColors.swift
//  TuraqApp
//
//  Created by Akyl on 26.02.2023.
//

import UIKit

extension UIColor {
    
    static let mainBlue: UIColor = UIColor(red: 24/255, green: 54/255, blue: 88/255, alpha: 1)
    static let middleBlue: UIColor = UIColor(red: 90/255, green: 128/255, blue: 200/255, alpha: 1)
    static let lightestBlue: UIColor = UIColor(red: 165/255, green: 196/255, blue: 255/255, alpha: 1)
    static let textGray: UIColor = UIColor(red: 136/255, green: 136/255, blue: 136/255, alpha: 1)
    static let disabledGray: UIColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
    static let error: UIColor = UIColor(red: 169/255, green: 63/255, blue: 85/255, alpha: 1)
    static let background: UIColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
    static var shimmer: [UIColor] {
        [UIColor(red: 245/255, green: 244/255, blue: 255/255, alpha: 1),
         UIColor(red: 250/255, green: 250/255, blue: 255/255, alpha: 1),
         UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1),
         UIColor(red: 250/255, green: 250/255, blue: 255/255, alpha: 1),
         UIColor(red: 245/255, green: 244/255, blue: 255/255, alpha: 1)]
    }
}
