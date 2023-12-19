//
//  ParkingHistoryInteractor.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 10.04.2023.
//

import Foundation
import Alamofire

protocol ParkingHistoryBusinessLogic {
    func loadHistory()
}

protocol ParkingHistoryDataStore {
    var history: [ParkingHistoryModels.History] { get set }
    var recordId: Int? { get set }
}

final class ParkingHistoryInteractor: ParkingHistoryBusinessLogic, ParkingHistoryDataStore {
    
    // MARK: - Public Properties
    
    var presenter: ParkingHistoryPresentationLogic?
    lazy var worker: ParkingHistoryWorkingLogic = ParkingHistoryWorker()
    
    // MARK: - Private Properties
    
    var history: [ParkingHistoryModels.History] = []
    var recordId: Int?
    
    // MARK: - Business Logic
    
    func loadHistory() {
        let token = KeychainHelper.standard.read(service: "token", account: "ios", type: String.self) ?? NetworkLayer.token
        let endPoint = "parking/history"
        let header: HTTPHeaders = [
            .authorization(bearerToken: token)
        ]
        
        NetworkLayer.shared.request(
            responseModel: [ParkingHistoryModels.History].self,
            endpoint: endPoint,
            method: .get,
            headers: header
        ) { result in
            switch result {
            case .success(let data):
                self.history = data
                self.presenter?.presentHistory(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
