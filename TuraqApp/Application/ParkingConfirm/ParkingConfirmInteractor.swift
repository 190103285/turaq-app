//
//  ParkingConfirmInteractor.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 12.04.2023.
//

import Foundation
import Alamofire

protocol ParkingConfirmBusinessLogic {
    func loadParkingInfo()
    func loadSelectedCar()
    func loadSelectedCard()
    func park(_ request: ParkingConfirmFlow.Something.Request)
}

protocol ParkingConfirmDataStore {
    var selectedParking :MainFlow.Status.Response? { get set }
    var selectedParkingId: Int? { get set }
}

final class ParkingConfirmInteractor: ParkingConfirmBusinessLogic, ParkingConfirmDataStore {
    
    // MARK: - Public Properties
    
    var presenter: ParkingConfirmPresentationLogic?
    lazy var worker: ParkingConfirmWorkingLogic = ParkingConfirmWorker()
    
    // MARK: - Private Properties
    
    var selectedParking: MainFlow.Status.Response?
    var parkingStatusResponse: MainFlow.Status.Response?
    var selectedParkingId: Int?

    
    // MARK: - Business Logic
    
    func loadParkingInfo() {
        let token = KeychainHelper.standard.read(service: "token", account: "ios", type: String.self) ?? NetworkLayer.token
        let endPoint = "parking/confirm"
        let header: HTTPHeaders = [
            .authorization(bearerToken: token)
        ]
        
        guard let selectedParkingId else {
            return
        }
        
        NetworkLayer.shared.request(
            responseModel: ParkingConfirmFlow.Something.Response.self,
            endpoint: endPoint,
            method: .get,
            parameters: ["parkingId": selectedParkingId],
            headers: header
        ) { result in
            switch result {
            case .success(let response):
                self.presenter?.presentParkingConfirm(response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadSelectedCar() {
        let token = KeychainHelper.standard.read(service: "token", account: "ios", type: String.self) ?? NetworkLayer.token
        let endPoint = "user/selected-car"
        let header: HTTPHeaders = [
            .authorization(bearerToken: token)
        ]
        
        NetworkLayer.shared.request(
            responseModel: CarModel.self,
            endpoint: endPoint,
            method: .get,
            headers: header
        ) { result in
            switch result {
            case .success(let response):
                self.presenter?.updateSelectedCar(response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadSelectedCard() {
        let token = KeychainHelper.standard.read(service: "token", account: "ios", type: String.self) ?? NetworkLayer.token
        let endPoint = "user/selected-card"
        let header: HTTPHeaders = [
            .authorization(bearerToken: token)
        ]
        
        NetworkLayer.shared.request(
            responseModel: CardModel.self,
            endpoint: endPoint,
            method: .get,
            headers: header
        ) { result in
            switch result {
            case .success(let response):
                self.presenter?.updateSelectedCard(response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func park(_ request: ParkingConfirmFlow.Something.Request) {
        let token = KeychainHelper.standard.read(service: "token", account: "ios", type: String.self) ?? NetworkLayer.token
        let endPoint = "parking/park"
        let header: HTTPHeaders = [
            .authorization(bearerToken: token),
            .accept("application/json"),
            .contentType("application/json")
        ]
        let parameters: [String: Any] = [
            "parkingId": request.parkingId,
            "startTime": request.startTime.timeIntervalSince1970,
            "endTime": request.endTime.timeIntervalSince1970,
        ]
        NetworkLayer.shared.request(
            responseModel: ParkingConfirmFlow.Park.Request.self,
            endpoint: endPoint,
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: header
        ) { result in
            switch result {
            case .success(let response):
                self.presenter?.presentSuccessfullPark(request.parkingId)
            case .failure(let error):
                switch error {
                case .serverError(let message):
                    print("Server error with message: \(message)")
                    self.presenter?.presentParkingError(message)
                default:
                    print(error.localizedDescription)
                }
            }
        }
    }
}
