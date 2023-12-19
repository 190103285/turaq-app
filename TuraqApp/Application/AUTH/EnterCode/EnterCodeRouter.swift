//
//  EnterCodeRouter.swift
//  TuraqApp
//
//  Created by Akyl on 27.02.2023.
//

import UIKit

protocol EnterCodeRoutingLogic {
    func routeToAddCar()
    func routeToMain()
}

protocol EnterCodeDataPassing {
    var dataStore: EnterCodeDataStore? { get }
}

final class EnterCodeRouter: EnterCodeRoutingLogic, EnterCodeDataPassing {
    
    // MARK: - Public Properties
    
    weak var parentController: UIViewController?
    weak var viewController: EnterCodeViewController?
    var dataStore: EnterCodeDataStore?
    
    // MARK: - Routing Logic
    
    func routeToAddCar() {
        guard let viewController = viewController else {
            fatalError("Failed route to ENTER CODE")
        }
        
        let mainVC = AddCarBuilder().makeScene()
        navigateToEnterCode(source: viewController, destination: mainVC)
    }
    
    func routeToMain() {
        guard let viewController = viewController else {
            fatalError("Failed route to Main")
        }
        
        let mainVC = MainBuilder().makeScene()
        navigateToMain(source: viewController, destination: mainVC)
    }
    
    // MARK: - Navigation
    
    private func navigateToEnterCode(source: EnterCodeViewController, destination: AddCarViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    private func navigateToMain(source: EnterCodeViewController, destination: MainViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
}
