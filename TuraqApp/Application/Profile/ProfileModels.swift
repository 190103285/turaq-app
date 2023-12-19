//
//  ProfileModels.swift
//  TuraqApp
//
//  Created by Akyl on 01.03.2023.
//

import UIKit

enum ProfileModels {
    
    // MARK: - Models
    
    enum DataCell {
        struct Params {
            let image: UIImage
            let phoneNumber: String
        }
    }
    
    enum SettingsCell {
        
        enum SettingsType {
            case language
            case push
            case location
        }
        
        struct Params {
            let settingsType: SettingsCell.SettingsType
            let isOn: Bool
            let name: String
            let icon: UIImage
        }
    }
    
    // MARK: - View Models
    
    enum Initial {
        
        struct Response: Decodable {
            let selectedCard: CardModel
            let username: String
            let selectedCar: CarModel
        }
        
        struct ViewModel {
            enum SectionType {
                case profileData(title: String, models: [ProfileModels.DataCell.Params])
                case settings(title: String, models: [ProfileModels.SettingsCell.Params])
                case deleteAccount(model: ProfileViewDeleteAccountCell.Params)
                case logout(model: ProfileViewLogoutCell.Params)
            }
            
            var sections: [SectionType]
        }
    }
}
