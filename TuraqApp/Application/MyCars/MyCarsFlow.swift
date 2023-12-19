//
//  MyCarsFlow.swift
//  TuraqApp
//
//  Created by Akyl on 05.03.2023.
//

import UIKit

enum MyCarsFlow {
  
    enum Initital {
        enum SectionType {
            case cars(title: String, models: [MyCarsViewCell.Params])
            case addNew
        }
        
        struct Request {}
        
        struct Response: Codable {
            let id: Int
            let regionalNumber: String
            let brand: String
            let model: String
            let selected: Bool
        }
        
        struct ViewModel {
            var sections: [SectionType]
        }
    }
}
