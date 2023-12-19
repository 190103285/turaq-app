//
//  HelpModels.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 24.04.2023.
//

import UIKit

enum HelpModels {
    
    // MARK: - Models
    
    // MARK: - View Models
    
    enum SectionType {
        case info(types: [RowType])
        case chat(title: String)
    }
    
    enum RowType: String {
        case privacyPolicy = "Политика конфиденциальности"
        case licenseAgreement = "Лицензионное соглашение"
        case faq = "FAQ"
    }
    
    enum Initital {
        
        struct ViewModel {
            let sections: [SectionType]
        }
    }
}
