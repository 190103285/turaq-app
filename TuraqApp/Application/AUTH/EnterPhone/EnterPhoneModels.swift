//
//  EnterPhoneModels.swift
//  TuraqApp
//
//  Created by Akyl on 24.02.2023.
//

import UIKit

enum EnterPhoneModels {
    
    // MARK: - Models
    
    // MARK: - View Models
    
    enum GetCode {
        
        struct Request {
            let phoneNumber: String
        }
        
        struct Response {
            let phoneNumber: String
        }
        
        struct ViewModel {
            let phoneNumber: String
        }
    }
}
