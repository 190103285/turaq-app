//
//  BookingInteractor.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 12.04.2023.
//

import Foundation
import Alamofire

protocol BookingBusinessLogic {
    func book(type: BookingView.BookingType)
}

protocol BookingDataStore {
    var parkingId: Int? { get set }
}

final class BookingInteractor: BookingBusinessLogic, BookingDataStore {
    
    // MARK: - Public Properties
    
    var presenter: BookingPresentationLogic?
    lazy var worker: BookingWorkingLogic = BookingWorker()
    
    var parkingId: Int?
    
    // MARK: - Business Logic
    
    func book(type: BookingView.BookingType) {
        let token = KeychainHelper.standard.read(service: "token", account: "ios", type: String.self) ?? NetworkLayer.token
        guard let parkingId else {
            return
        }
        let endPoint =  type == .paid ? "parking/paid-book" : "parking/free-book"
        let parameters: [String: Any] = ["parkingId": parkingId]
        let header: HTTPHeaders = [
            .authorization(bearerToken: token),
        ]
        NetworkLayer.shared.request(
            endpoint: endPoint,
            method: .post,
            parameters: parameters,
            headers: header
        ) { result in
            switch result {
            case .success(let response):
                self.presenter?.presentBookedView(parkingId)
            case .failure(let error):
                switch error {
                case .serverError(let message):
                    print("Server error with message: \(message)")
                    self.presenter?.presentBookingError(message)
                default:
                    print(error.localizedDescription)
                }
            }
        }
    }
}
