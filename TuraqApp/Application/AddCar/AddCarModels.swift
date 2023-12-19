//
//  AddCarModels.swift
//  TuraqApp
//
//  Created by Akyl on 10.03.2023.
//

import UIKit

enum AddCarModels {
    
    // MARK: - Models
    
    // MARK: - View Models
    
    enum AddCar {
        
        struct Request: Encodable {
            let regNumber: String
            let brand: String
            let model: String
        }
        
        struct Response: Decodable {
            let message: String
            let isFirstCar: String
        }
        
        struct ViewModel {}
    }
}
