//
//  AddCardRouter.swift
//  TuraqApp
//
//  Created by Akyl on 10.03.2023.
//

import UIKit

protocol AddCardRoutingLogic {
    func routeToMain()
}

protocol AddCardDataPassing {
    var dataStore: AddCardDataStore? { get }
}

final class AddCardRouter: AddCardRoutingLogic, AddCardDataPassing {
    
    // MARK: - Public Properties
    
    weak var parentController: UIViewController?
    weak var viewController: AddCardViewController?
    var dataStore: AddCardDataStore?
    
    // MARK: - Private Properties
    
    //
    
    // MARK: - Routing Logic
    
    func routeToMain() {
        guard let viewController = viewController else {
            fatalError("Failed route to ENTER CODE")
        }
        
        let mainVC = MainBuilder().makeScene()
        
//        passDataToEnterCode(source: enterCodeDS, destination: &mainDS)
        navigateToMain(source: viewController, destination: mainVC)
    }
    
    // MARK: - Navigation
    
    private func navigateToMain(source: AddCardViewController, destination: MainViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: - Passing data
    
    private func passDataToMain(source: AddCarDataStore, destination: inout MainDataStore) {
        
    }
}
