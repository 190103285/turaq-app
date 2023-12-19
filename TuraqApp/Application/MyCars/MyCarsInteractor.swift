//
//  MyCarsInteractor.swift
//  TuraqApp
//
//  Created by Akyl on 05.03.2023.
//

import Foundation
import Alamofire

protocol MyCarsBusinessLogic {
    func loadMyCars()
    func setCar(with id: Int)
}

protocol MyCarsDataStore {
    var myCarsModels: [MyCarsFlow.Initital.SectionType] { get set }
}

final class MyCarsInteractor: MyCarsBusinessLogic, MyCarsDataStore {
    
    // MARK: - Public Properties
    
    var presenter: MyCarsPresentationLogic?
    lazy var worker: MyCarsWorkingLogic = MyCarsWorker()
    
    var myCarsModels: [MyCarsFlow.Initital.SectionType] = []
    
    // MARK: - Private Properties
    
    //
    
    // MARK: - Business Logicb
    
    func loadMyCars() {
        let token = KeychainHelper.standard.read(service: "token", account: "ios", type: String.self) ?? NetworkLayer.token
        let endPoint = "user/cars"
        let header: HTTPHeaders = [
            .accept("application/json"),
            .contentType("application/json"),
            .authorization(bearerToken: token)
        ]
        
        NetworkLayer.shared.request(
            responseModel: [CarModel].self,
            endpoint: endPoint,
            method: .get,
            headers: header
        ) { result in
            switch result {
            case .success(let data):
                self.presenter?.presentMyCars(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func setCar(with id: Int) {
        let token = KeychainHelper.standard.read(service: "token", account: "ios", type: String.self) ?? NetworkLayer.token
        let endPoint = "user/select-car"
        let header: HTTPHeaders = [
            .authorization(bearerToken: token)
        ]
        
        NetworkLayer.shared.request(
            endpoint: endPoint,
            method: .put,
            parameters:  ["id": id],
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
