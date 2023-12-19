//
//  MainInteractor.swift
//  TuraqApp
//
//  Created by Akyl on 28.02.2023.
//

import Foundation
import Alamofire
import GoogleMaps

protocol MainBusinessLogic {
    func getParkings()
    func getParkingStatus(_ request: MainFlow.Status.Request)
}

protocol MainDataStore {
    var parkings: [GMSMarker: MainFlow.RenderedParkingModel] { get set }
    var selectedParking: MainFlow.RenderedParkingModel? { get set }
    var parkingStatusResponse: MainFlow.Status.Response? { get set }
}

final class MainInteractor: MainBusinessLogic, MainDataStore {
    
    // MARK: - Public Properties
    
    var presenter: MainPresentationLogic?
    lazy var worker: MainWorkingLogic = MainWorker()
    
    // MARK: - Private Properties
    
    var parkings: [GMSMarker: MainFlow.RenderedParkingModel] = [:]
    var selectedParking: MainFlow.RenderedParkingModel?
    
    var parkingStatusResponse: MainFlow.Status.Response?
    
    // MARK: - Business Logic
    
    func getParkings() {
        let endPoint = "parking"
        let header: HTTPHeaders = [
            .accept("application/json")
        ]
        
        NetworkLayer.shared.request(
            responseModel: [ParkingModel].self,
            endpoint: endPoint,
            method: .get,
            encoding: JSONEncoding.default,
            headers: header
        ) { result in
            switch result {
            case .success(let response):
                self.presenter?.presentParkings(response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getParkingStatus(_ request: MainFlow.Status.Request) {
        let token = KeychainHelper.standard.read(service: "token", account: "ios", type: String.self) ?? NetworkLayer.token
        let endpoint = "parking/status"
        let header: HTTPHeaders = [
            .authorization(bearerToken: token)
        ]
        NetworkLayer.shared.request(
            responseModel: MainFlow.Status.Response.self,
            endpoint: endpoint,
            method: .get,
            parameters: ["parkingId": request.parkingId],
            headers: header
        ) { result in
            switch result {
            case .success(let response):
                self.parkingStatusResponse = response
                self.presenter?.presentSelectedParking(response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func isTokenExpired(token: String, completion: ((Bool) -> Void)? = nil) {
        let endpoint = "check-token"
        NetworkLayer.shared.request(
            endpoint: endpoint,
            method: .get,
            parameters: ["token": token],
            headers: nil
        ) { result in
            switch result {
            case .success:
                completion?(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion?(false)
            }
        }
    }
}
