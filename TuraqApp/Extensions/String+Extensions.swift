//
//  String+Extensions.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 03.05.2023.
//

import Foundation

extension String {
    func localized() -> String {
        NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
