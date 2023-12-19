//
//  AddCarRouter.swift
//  TuraqApp
//
//  Created by Akyl on 10.03.2023.
//

import UIKit

protocol AddCarRoutingLogic {
    func routeToAddCard()
}

protocol AddCarDataPassing {
    var dataStore: AddCarDataStore? { get }
}

final class AddCarRouter: AddCarRoutingLogic, AddCarDataPassing {
    
    // MARK: - Public Properties
    
    weak var parentController: UIViewController?
    weak var viewController: AddCarViewController?
    var dataStore: AddCarDataStore?
    
    // MARK: - Routing Logic
    
    func routeToAddCard() {
        guard let viewController = viewController else {
            fatalError("Failed route to Add Card")
        }
        let addCardVC = AddCardBuilder().makeScene()
        
        navigateToAddCard(source: viewController, destination: addCardVC)
    }
    
    // MARK: - Navigation
    
    private func navigateToAddCard(source: AddCarViewController, destination: AddCardViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
}
