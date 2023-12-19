//
//  EnterCodeModels.swift
//  TuraqApp
//
//  Created by Akyl on 27.02.2023.
//

import UIKit

enum EnterCodeModels {
    
    // MARK: - Models
    
    // MARK: - View Models
    
    enum EnterCode {
        
        struct Request {
            let otp: String
        }
        
        struct Response: Decodable {
            let message: String
            let accessToken: String
            let showAddCar: String
        }
        
        struct ViewModel {
            let phoneNumber: String
        }
    }
}
