//
//  EnterCodeInteractor.swift
//  TuraqApp
//
//  Created by Akyl on 27.02.2023.
//

import Foundation
import Alamofire

protocol EnterCodeBusinessLogic {
    func showEnterCode()
    func checkCode(_ request: EnterCodeModels.EnterCode.Request)
    func resendCode()
}

protocol EnterCodeDataStore {
    var phoneNumber: String { get set }
}

final class EnterCodeInteractor: EnterCodeBusinessLogic, EnterCodeDataStore {
    
    // MARK: - Public Properties
    
    var presenter: EnterCodePresentationLogic?
    lazy var worker: EnterCodeWorkingLogic = EnterCodeWorker()
    
    var phoneNumber: String = ""
    
    // MARK: - Business Logic
    
    func showEnterCode() {
        presenter?.presentEnterCode(phoneNumber)
    }
    
    func checkCode(_ request: EnterCodeModels.EnterCode.Request) {
        let endpoint = "validate"
        let header: HTTPHeaders = [
            .accept("application/json"),
            .contentType("application/json")
        ]
        let parameters: [String: Any] = [
            "phoneNumber": phoneNumber,
            "otp": request.otp
        ]
        NetworkLayer.shared.request(
            responseModel: EnterCodeModels.EnterCode.Response.self,
            endpoint: endpoint,
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: header
        ) { result in
            switch result {
            case .success(let data):
                KeychainHelper.standard.save(data.accessToken, service: "token", account: "ios")
                NetworkLayer.token = data.accessToken
                if data.showAddCar == "true" {
                    self.presenter?.presentAddCar()
                } else {
                    self.presenter?.presentMain()
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.presenter?.presentInvalidCode()
            }
        }
    }
    
    func resendCode() {
        let endpoint = "register"
        NetworkLayer.shared.request(endpoint: endpoint,
                                     method: .post,
                                     parameters: ["phoneNumber": phoneNumber],
                                     headers: nil) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            default:
                break
            }
        }
    }
}
