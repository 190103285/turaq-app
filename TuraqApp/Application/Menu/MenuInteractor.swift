//
//  MenuInteractor.swift
//  TuraqApp
//
//  Created by Akyl on 12.03.2023.
//

import Foundation
import Alamofire

protocol MenuBusinessLogic {
    func loadMenu()
}

protocol MenuDataStore {
    
}

final class MenuInteractor: MenuBusinessLogic, MenuDataStore {
    
    // MARK: - Public Properties
    
    var presenter: MenuPresentationLogic?
    lazy var worker: MenuWorkingLogic = MenuWorker()
    
    // MARK: - Business Logic
    
    func loadMenu() {
        let token = KeychainHelper.standard.read(service: "token", account: "ios", type: String.self) ?? ""
        let endPoint = "user"
        let header: HTTPHeaders = [
            .accept("application/json"),
            .contentType("application/json"),
            .authorization(bearerToken: token)
        ]
        
        NetworkLayer.shared.request(
            responseModel: MenuModels.Initial.Response.self,
            endpoint: endPoint,
            method: .get,
            headers: header
        ) { result in
            switch result {
            case .success(let response):
                self.presenter?.presentMenu(response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
