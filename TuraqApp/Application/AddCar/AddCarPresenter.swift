//
//  AddCarPresenter.swift
//  TuraqApp
//
//  Created by Akyl on 10.03.2023.
//

import UIKit

protocol AddCarPresentationLogic {
    func presentValidatedCar()
    func dismissAddCar()
    func presentAddingError()
}

final class AddCarPresenter: AddCarPresentationLogic {
    
    // MARK: - Public Properties
    
    weak var viewController: AddCarDisplayLogic?
    
    // MARK: - Private Properties
    
    //
    
    // MARK: - Presentation Logic
    
    func presentValidatedCar() {
        viewController?.displayValidatedCar()
    }
    
    func dismissAddCar() {
        viewController?.dismissAddCar()
    }
    
    func presentAddingError() {
        viewController?.displayAddingError()
    }
}
