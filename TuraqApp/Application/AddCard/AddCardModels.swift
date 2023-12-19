//
//  AddCardModels.swift
//  TuraqApp
//
//  Created by Akyl on 10.03.2023.
//

import UIKit

enum AddCardModels {
    
    // MARK: - Models
    
    // MARK: - View Models
    
    enum AddCard {
        
        struct Request {
            let cardId: String
            let expirationDate: String
            let cvv: String
        }
        
        struct Response: Decodable {
            let message: String
            let isFirstCard: String
        }
    }
}
