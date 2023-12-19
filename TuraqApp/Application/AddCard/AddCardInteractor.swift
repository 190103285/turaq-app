//
//  AddCardInteractor.swift
//  TuraqApp
//
//  Created by Akyl on 10.03.2023.
//

import Foundation
import Alamofire

protocol AddCardBusinessLogic {
    func validateCard(_ request: AddCardModels.AddCard.Request)
}

protocol AddCardDataStore {
    
}

final class AddCardInteractor: AddCardBusinessLogic, AddCardDataStore {
    
    // MARK: - Public Properties
    
    var presenter: AddCardPresentationLogic?
    lazy var worker: AddCardWorkingLogic = AddCardWorker()
    
    // MARK: - Business Logic
    
    func validateCard(_ request: AddCardModels.AddCard.Request) {
        let token = KeychainHelper.standard.read(service: "token", account: "ios", type: String.self) ?? NetworkLayer.token
        let endPoint = "register-card"
        
        let header: HTTPHeaders = [
            .accept("application/json"),
            .contentType("application/json"),
            .authorization(bearerToken: token)
        ]
        
        let parameters: [String: Any] = [
            "cardId": request.cardId,
            "expirationDate": request.expirationDate,
            "cvv": request.cvv
        ]
        
        NetworkLayer.shared.request(
            responseModel: AddCardModels.AddCard.Response.self,
            endpoint: endPoint,
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: header
        ) { result in
            switch result {
            case .success(let data):
                if data.isFirstCard == "true" {
                    self.presenter?.presentValidatedCard()
                } else {
                    self.presenter?.dismissAddCard()
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.presenter?.presentAddingError()
            }
        }
    }
}
