//
//  MainFlow.swift
//  TuraqApp
//
//  Created by Akyl on 28.02.2023.
//

import UIKit
import CoreLocation

enum MainFlow {
    
    // MARK: - Something
    
    struct RenderedParkingModel {
        let id: Int
        let name: String
        let coordinates: CLLocationCoordinate2D
        let capacity: Int
        let places: [Place]
    }
    
    enum Something {
        
        struct ViewModel {
            let parkings: [RenderedParkingModel]
        }
    }
    
    enum Status {
        struct Response: Decodable {
            let status: String
            let car: CarModel?
            let startTime: Double?
            let endTime: Double?
            let parkingId: Int
            let parkingName: String
            let parkingLatitude: Double
            let parkingLongitude: Double
            let parkingEmptyPlace: Int
            let price: Int
        }
        
        struct Request {
            let parkingId: Int
        }
        
        struct ParkingStatusViewModel {
            var type: ParkingStateView.ActionType
            var timeLeft: Double
            var timerText: String
            var parkingId: Int
            var parkingName: String
            var secondaryButtonTitle: String
            var primaryButtonTitle: String
            var carId: Int
            var carRegNumber: String
            var carName: String
        }
        
        struct ParkingViewModel {
            var parkingId: Int
            var parkingName: String
            var emptyPlace: Int
        }
    }
}
