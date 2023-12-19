//
//  InitialConfigurator.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 09.04.2023.
//

import IQKeyboardManagerSwift

enum InitialConfigurator {
    static func configure() {
        configureKeyboardManager()
    }
    
    private static func configureKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysHide
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Готово"
        IQKeyboardManager.shared.toolbarTintColor = .mainBlue
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 50
    }
}
