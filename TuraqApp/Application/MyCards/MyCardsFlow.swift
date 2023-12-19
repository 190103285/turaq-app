//
//  MyCardsFlow.swift
//  TuraqApp
//
//  Created by Akyl on 07.03.2023.
//

import UIKit

enum MyCardsFlow {
    
    // MARK: - Something
    
    enum Initital {
        enum SectionType {
            case cards(title: String, models: [MyCardsViewCell.Params])
            case addNew
        }
        
        struct Request {}
        
        struct Response: Decodable {
            let id: Int
            let cardId: String
            let expirationDate: String
            let cvv: String
            let selected: Bool
        }
        
        struct ViewModel {
            var sections: [SectionType]
        }
    }
}
