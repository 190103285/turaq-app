//
//  AddCarInteractor.swift
//  TuraqApp
//
//  Created by Akyl on 10.03.2023.
//

import Foundation
import Alamofire

protocol AddCarBusinessLogic {
    func validateCar(_ request: AddCarModels.AddCar.Request)
}

protocol AddCarDataStore {
    
}

final class AddCarInteractor: AddCarBusinessLogic, AddCarDataStore {
    
    // MARK: - Public Properties
    
    var presenter: AddCarPresentationLogic?
    lazy var worker: AddCarWorkingLogic = AddCarWorker()
    
    // MARK: - Business Logic
    
    func validateCar(_ request: AddCarModels.AddCar.Request) {
        let token = KeychainHelper.standard.read(service: "token", account: "ios", type: String.self) ?? NetworkLayer.token
        let endPoint = "register-car"
        let header: HTTPHeaders = [
            .accept("application/json"),
            .contentType("application/json"),
            .authorization(bearerToken: token)
        ]
        let parameters: [String: Any] = [
            "regionalNumber": request.regNumber,
            "brand": request.brand,
            "model": request.model
        ]
        
        NetworkLayer.shared.request(
            responseModel: AddCarModels.AddCar.Response.self,
            endpoint: endPoint,
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: header
        ) { result in
            switch result {
            case .success(let data):
                if data.isFirstCar == "true" {
                    self.presenter?.presentValidatedCar()
                } else {
                    self.presenter?.dismissAddCar()
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.presenter?.presentAddingError()
            }
        }
    }
}
