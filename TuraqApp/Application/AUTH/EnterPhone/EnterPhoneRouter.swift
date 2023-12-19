//
//  EnterPhoneRouter.swift
//  TuraqApp
//
//  Created by Akyl on 24.02.2023.
//

import UIKit

protocol EnterPhoneRoutingLogic {
    func routeToEnterCode()
}

protocol EnterPhoneDataPassing {
    var dataStore: EnterPhoneDataStore? { get }
}

final class EnterPhoneRouter: EnterPhoneRoutingLogic, EnterPhoneDataPassing {
    
    // MARK: - Public Properties
    
    weak var parentController: UIViewController?
    weak var viewController: EnterPhoneViewController?
    var dataStore: EnterPhoneDataStore?
    
    // MARK: - Routing Logic
    
    func routeToEnterCode() {
        guard let viewController = viewController,
              let enterPhoneDS = dataStore else { fatalError("Failed route to Enter Code")
        }
        let enterCodeVC = EnterCodeBuilder().makeScene()
        
        guard var enterCodeDS = enterCodeVC.router?.dataStore else {
            return
        }
        
        passDataToEnterCode(source: enterPhoneDS, destination: &enterCodeDS)
        navigateToEnterCode(source: viewController, destination: enterCodeVC)
    }
    
    // MARK: - Navigation
    
    private func navigateToEnterCode(source: EnterPhoneViewController, destination: EnterCodeViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
        source.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Passing data
    
    private func passDataToEnterCode(source: EnterPhoneDataStore, destination: inout EnterCodeDataStore) {
        destination.phoneNumber = source.phoneNumber
    }
}
