//
//  ProfileInteractor.swift
//  TuraqApp
//
//  Created by Akyl on 01.03.2023.
//

import Foundation
import Alamofire

protocol ProfileBusinessLogic {
    func loadProfile(_ isPushOn: Bool)
    func logout()
    func deleteAccount(with id: Int)
    func receivedPermission(isPushOn: Bool)
}

protocol ProfileDataStore {
    var myCarsModels: [MyCarsFlow.Initital.SectionType] { get set }
    var myCardsModels: [MyCardsFlow.Initital.SectionType] { get set }
}

final class ProfileInteractor: ProfileBusinessLogic, ProfileDataStore {
    
    // MARK: - Public Properties
    
    var presenter: ProfilePresentationLogic?
    lazy var worker: ProfileWorkingLogic = ProfileWorker()
    
    var myCarsModels: [MyCarsFlow.Initital.SectionType] = []
    var myCardsModels: [MyCardsFlow.Initital.SectionType] = []
    
    // MARK: - Private Properties
    
    // MARK: - Business Logic
    
    func loadProfile(_ isPushOn: Bool) {
        let token = KeychainHelper.standard.read(service: "token", account: "ios", type: String.self) ?? NetworkLayer.token
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
                self.presenter?.presentProfile(response, isPushOn)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func logout() {
        let token = KeychainHelper.standard.read(service: "token", account: "ios", type: String.self) ?? NetworkLayer.token
        let endPoint = "user/logout"
        let header: HTTPHeaders = [
            .authorization(bearerToken: token)
        ]
        
        NetworkLayer.shared.request(
            endpoint: endPoint,
            method: .post,
            headers: header
        ) { result in
            switch result {
            case .success(let response):
                KeychainHelper.standard.delete(service: "token", account: "ios")
                self.presenter?.profilePresentationLogicLogouted()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteAccount(with id: Int) {
        let token = KeychainHelper.standard.read(service: "token", account: "ios", type: String.self) ?? NetworkLayer.token
        let endPoint = "user/delete"
        let parameters: [String: Any] = ["userId": id]
        let header: HTTPHeaders = [
            .authorization(bearerToken: token)
        ]
        
        NetworkLayer.shared.request(
            endpoint: endPoint,
            method: .delete,
            parameters: parameters,
            headers: header
        ) { result in
            switch result {
            case .success(let response):
                KeychainHelper.standard.delete(service: "token", account: "ios")
                self.presenter?.profilePresentationLogicLogouted()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func receivedPermission(isPushOn: Bool) {
        presenter?.receivedPermission(isPushOn: isPushOn)
    }
}
