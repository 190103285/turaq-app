//
//  MenuModels.swift
//  TuraqApp
//
//  Created by Akyl on 12.03.2023.
//

import UIKit

enum MenuModels {
    
    // MARK: - Models
    
    enum Initial {
        
        struct Response: Decodable {
            let userId: Int
            let username: String
            let selectedCard: CardModel
            let selectedCar: CarModel
        }
        
        struct ViewModel {
            enum SectionType {
                case profile(phoneNumber: String)
                case mys(carModel: CarModel, cardModel: CardModel)
                case help
                case history
            }
            
            enum MyType {
                case cars
                case cards
            }
            
            var sections: [SectionType]
        }
    }
}
