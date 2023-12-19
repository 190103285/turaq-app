//
//  AddCardPresenter.swift
//  TuraqApp
//
//  Created by Akyl on 10.03.2023.
//

import UIKit

protocol AddCardPresentationLogic {
    func presentValidatedCard()
    func dismissAddCard()
    func presentAddingError()
}

final class AddCardPresenter: AddCardPresentationLogic {
    
    // MARK: - Public Properties
    
    weak var viewController: AddCardDisplayLogic?
    
    // MARK: - Private Properties
    
    //
    
    // MARK: - Presentation Logic
    
    func presentValidatedCard() {
        viewController?.displayValidatedCard()
    }
    
    func dismissAddCard() {
        viewController?.dismissAddCard()
    }
    
    func presentAddingError() {
        viewController?.displayAddingError()
    }
}
