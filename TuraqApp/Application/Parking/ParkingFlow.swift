//
//  ParkingFlow.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 10.04.2023.
//

import UIKit
import CoreLocation

enum ParkingFlow {    
    enum Something {
        
        struct ParkingModel {
            let id: Int
            let name: String
            let coordinates: CLLocationCoordinate2D
            let capacity: Int
            let places: [Place]
        }
        
        struct ViewModel {
            let name: String
            let availablePlaces: String
        }
    }
}
