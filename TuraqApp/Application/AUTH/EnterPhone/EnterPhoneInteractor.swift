//
//  EnterPhoneInteractor.swift
//  TuraqApp
//
//  Created by Akyl on 24.02.2023.
//

import Alamofire

protocol EnterPhoneBusinessLogic {
    func getCode(_ request: EnterPhoneModels.GetCode.Request)
}

protocol EnterPhoneDataStore {
    var phoneNumber: String { get set }
}

final class EnterPhoneInteractor: EnterPhoneBusinessLogic, EnterPhoneDataStore {
    
    // MARK: - Public Properties
    
    var presenter: EnterPhonePresentationLogic?
    lazy var worker: EnterPhoneWorkingLogic = EnterPhoneWorker()
    
    // MARK: - Data Store
    
    var phoneNumber: String = ""
    
    // MARK: - Business Logic
    
    func getCode(_ request: EnterPhoneModels.GetCode.Request) {
        guard request.phoneNumber.count == 16 else {
            self.presenter?.presentError()
            return
        }
        phoneNumber = request.phoneNumber
        let endpoint = "register"
        NetworkLayer.shared.request(endpoint: endpoint,
                                    method: .post,
                                    parameters: ["phoneNumber": phoneNumber],
                                    headers: nil) { result in
            switch result {
            case .success:
                self.presenter?.presentEnterCode()
            case .failure(let error):
                print(error.localizedDescription)
                self.presenter?.presentError()
            }
        }
    }
}
