//
//  EnterPhonePresenter.swift
//  TuraqApp
//
//  Created by Akyl on 24.02.2023.
//

import UIKit

protocol EnterPhonePresentationLogic {
    func presentEnterCode()
    func presentError()
}

final class EnterPhonePresenter: EnterPhonePresentationLogic {
    
    // MARK: - Public Properties
    
    weak var viewController: EnterPhoneDisplayLogic?
    
    // MARK: - Presentation Logic
    
    func presentEnterCode() {
        viewController?.displayEnterCode()
    }
    
    func presentError() {
        viewController?.displayError()
    }
}
