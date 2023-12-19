//
//  ParkingConfirmFlow.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 12.04.2023.
//

import UIKit

enum ParkingConfirmFlow {
    
    enum Something {
        struct Request {
            let parkingId: Int
            let startTime: Date
            let endTime: Date
        }
        
        struct Response: Decodable {
            let selectedCar: CarModel
            let selectedCard: CardModel
            let parking: ParkingModel
        }
        
        struct ViewModel {
            let parkingId: Int
            let parkingName: String
            let selectedCarName: String
            let selectedCardName: String
            let selectedCardType: String
            let placePrice: Int
        }
    }
    
    enum Park {
        struct Request: Decodable {
            let message: String
        }
    }
    
    enum SelectedCar {
        struct ViewModel {
            let carName: String
        }
    }
    
    enum SelectedCard {
        struct ViewModel {
            let cardId: String
            let cardType: String
        }
    }
    
    enum ParkingError {
        
        struct AlertModel {
            let title: String
            let message: String
            let image: String
            let buttonText: String
        }
    }
}
