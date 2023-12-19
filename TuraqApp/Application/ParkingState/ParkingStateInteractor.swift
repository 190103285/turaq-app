//
//  ParkingStateInteractor.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 16.04.2023.
//

import Foundation
import Alamofire

protocol ParkingStateBusinessLogic {
    func loadStatus()
    func unpark(_ request: ParkingStateModels.Leave.Request)
    func unbook(_ id: Int)
}

protocol ParkingStateDataStore {
    var selectedParkingStatus: MainFlow.Status.Response? { get set }
}

final class ParkingStateInteractor: ParkingStateBusinessLogic, ParkingStateDataStore {
    
    // MARK: - Public Properties
    
    var presenter: ParkingStatePresentationLogic?
    lazy var worker: ParkingStateWorkingLogic = ParkingStateWorker()
    
    var selectedParkingStatus: MainFlow.Status.Response?
    
    // MARK: - Private Properties
    
    //
    
    // MARK: - Business Logic
    
    func loadStatus() {
        if let selectedParkingStatus {
            presenter?.presentParkingStatus(selectedParkingStatus)
        }
    }
    
    func unpark(_ request: ParkingStateModels.Leave.Request) {
        let token = KeychainHelper.standard.read(service: "token", account: "ios", type: String.self) ?? NetworkLayer.token
        let endPoint = "parking/unpark"
        let header: HTTPHeaders = [
            .authorization(bearerToken: token),
        ]
        let parameters: [String: Any] = [
            "parkingId": request.parkingId,
            "carId": request.carId
        ]
        NetworkLayer.shared.request(
            endpoint: endPoint,
            method: .post,
            parameters: parameters,
            headers: header
        ) { result in
            switch result {
            case .success(let response):
                self.presenter?.presentUnparkedAlert()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func unbook(_ id: Int) {
        let token = KeychainHelper.standard.read(service: "token", account: "ios", type: String.self) ?? NetworkLayer.token
        let endPoint = "parking/unbook"
        let header: HTTPHeaders = [
            .authorization(bearerToken: token),
        ]
        let parameters: [String: Any] = [
            "parkingId": id
        ]
        NetworkLayer.shared.request(
            endpoint: endPoint,
            method: .post,
            parameters: parameters,
            headers: header
        ) { result in
            switch result {
            case .success(let response):
                return
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
