//
//  CarModel.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 15.04.2023.
//

import Foundation

struct CarModel: Decodable {
    let id: Int
    let brand: String
    let model: String
    let regionalNumber: String
    let selected: Bool
}

struct CardModel: Decodable {
    let id: Int
    let cardId: String
    let expirationDate: String
    let cvv: String
    let selected: Bool
}

struct ParkingModel: Decodable {
    let id: Int
    let name: String
    let latitude: Double
    let longitude: Double
    let capacity: Int
    let price: Int
    let places: [Place]
}

struct Place: Decodable {
    let id: Int
    let parkingStatus: String
    let parkingStartTime: Double?
    let parkingEndTime: Double?
    let parkedCar: CarModel?
}


