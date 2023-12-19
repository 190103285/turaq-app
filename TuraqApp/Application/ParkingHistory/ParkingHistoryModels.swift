//
//  ParkingHistoryModels.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 10.04.2023.
//

import UIKit

enum ParkingHistoryModels {
    
    // MARK: - Models
    
    struct History: Decodable {
        let id: Int
        let userId: Int
        let parkingStartTime: Double
        let parkingEndTime: Double
        let parking: ParkingModel
        let totalCost: Int
        let paymentCard: CardModel
        let car: CarModel
    }
    
    // MARK: - View Models
    
    enum Something {
        struct Request {}
        
        struct Response: Decodable {
            let records: [History]
        }
        
        struct ViewModel {
            let sections: [Section]
        }
        
        struct Section {
            let sectionTitle: String
            let records: [Record]
        }
        
        struct Record {
            let id: Int
            let dateText: String
            let parkingName: String
        }
    }
}
