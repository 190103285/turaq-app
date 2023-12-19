//
//  EnterCodePresenter.swift
//  TuraqApp
//
//  Created by Akyl on 27.02.2023.
//

import UIKit

protocol EnterCodePresentationLogic {
    func presentEnterCode(_ phoneNumber: String)
    func presentAddCar()
    func presentInvalidCode()
    func presentMain()
}

final class EnterCodePresenter: EnterCodePresentationLogic {
    
    // MARK: - Public Properties
    
    weak var viewController: EnterCodeDisplayLogic?
    
    // MARK: - Private Properties
    
    //
    
    // MARK: - Presentation Logic
    
    func presentEnterCode(_ phoneNumber: String) {
        let viewModel = EnterCodeModels.EnterCode.ViewModel(phoneNumber: phoneNumber)
        viewController?.displayEnterCode(viewModel)
    }
    
    func presentAddCar() {
        viewController?.displayRegisterCar()
    }
    
    func presentInvalidCode() {
        viewController?.displayInvalidCode()
    }
    
    func presentMain() {
        viewController?.displayMain()
    }
}
