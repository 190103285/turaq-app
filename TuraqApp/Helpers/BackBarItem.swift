//
//  BackBarIterm.swift
//  TuraqApp
//
//  Created by Akyl on 28.02.2023.
//

import UIKit

public class BackBarButtonItem: UIButton {
    
    public static func make(backButtonImage: UIImage? = UIImage(named: "back_button"),
                            backButtonTitle: String? = nil,
                            backButtonfont: UIFont? = nil,
                            backButtonTitleColor: UIColor? = nil) -> UIButton {
        let button = UIButton(type: .system)
        button.frame.size = CGSize(width: 40, height: 40)
        if let backButtonImage = backButtonImage {
            button.setImage(backButtonImage, for: .normal)
        }
        if let backButtonTitle = backButtonTitle {
            button.setTitle(backButtonTitle, for: .normal)
        }
        if let backButtonfont = backButtonfont {
            button.titleLabel?.font = backButtonfont
        }
        if let backButtonTitleColor = backButtonTitleColor {
            button.setTitleColor(backButtonTitleColor, for: .normal)
        }
        
        return button
    }
}
