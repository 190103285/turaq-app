//
//  MyCardsInteractor.swift
//  TuraqApp
//
//  Created by Akyl on 07.03.2023.
//

import Foundation
import UIKit
import Alamofire

protocol MyCardsBusinessLogic {
    func loadMyCards()
    func setCard(with id: Int)
}

protocol MyCardsDataStore {
    var myCardsModels: [MyCardsFlow.Initital.SectionType] { get set }
}

final class MyCardsInteractor: MyCardsBusinessLogic, MyCardsDataStore {
    
    // MARK: - Public Properties
    
    var presenter: MyCardsPresentationLogic?
    lazy var worker: MyCardsWorkingLogic = MyCardsWorker()
    
    var myCardsModels: [MyCardsFlow.Initital.SectionType] = []
    
    // MARK: - Private Properties
    
    //
    
    // MARK: - Business Logic
    
    func loadMyCards() {
        let token = KeychainHelper.standard.read(service: "token", account: "ios", type: String.self) ?? NetworkLayer.token
        let endPoint = "user/cards"
        let header: HTTPHeaders = [
            .accept("application/json"),
            .contentType("application/json"),
            .authorization(bearerToken: token)
        ]
        
        NetworkLayer.shared.request(
            responseModel: [CardModel].self,
            endpoint: endPoint,
            method: .get,
            headers: header
        ) { result in
            switch result {
            case .success(let response):
                self.presenter?.presentMyCards(response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func setCard(with id: Int) {
        let token = KeychainHelper.standard.read(service: "token", account: "ios", type: String.self) ?? NetworkLayer.token
        let endPoint = "user/select-card"
        let parameters: [String: Any] = [
            "id": Int64(id)
        ]
        let header: HTTPHeaders = [
            .authorization(bearerToken: token)
        ]
        
        NetworkLayer.shared.request(
            endpoint: endPoint,
            method: .put,
            parameters: parameters,
            headers: header
        ) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            default:
                break
            }
        }
    }
}
