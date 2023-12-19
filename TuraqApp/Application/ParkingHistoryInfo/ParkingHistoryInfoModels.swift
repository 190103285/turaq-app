//
//  ParkingHistoryInfoModels.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 12.04.2023.
//

import UIKit

enum ParkingHistoryInfoModels {
    
    // MARK: - Models
    
    // MARK: - View Models

    enum Info {
        struct ViewModel {
            var sections: [RowType]
            var headerModel: ReceiptModel
        }
        
        struct TimeModel {
            let title: String
            let subtitle: String
            let startTime: String
            let timeOnParking: String
        }
        
        struct CarModel {
            let carTitle: String
            let carRegNumber: String
            let carName: String
        }
        
        struct PaymentModel {
            let paymentTitle: String
            let paymentType: String
            let paymentCardId: String
        }
        
        struct ReceiptModel {
            let header: String
            let initialPrice: String
            let penaltyPrice: String
            let totalPrice: String
        }
        
        enum RowType {
            case time(model: TimeModel)
            case car(model: CarModel)
            case payment(model: PaymentModel)
        }
    }
}
