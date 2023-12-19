//
//  MyCardsRouter.swift
//  TuraqApp
//
//  Created by Akyl on 07.03.2023.
//

import UIKit

protocol MyCardsRoutingLogic {
    func routeToAddCard()
}

protocol MyCardsDataPassing {
    var dataStore: MyCardsDataStore? { get }
}

final class MyCardsRouter: MyCardsRoutingLogic, MyCardsDataPassing {
    
    // MARK: - Public Properties
    
    weak var parentController: UIViewController?
    weak var viewController: MyCardsViewController?
    var dataStore: MyCardsDataStore?
    
    // MARK: - Private Properties
    
    //
    
    // MARK: - Routing Logic
    
    func routeToAddCard() {
        guard let viewController = viewController else {
            fatalError("Failed route to ENTER CODE")
        }
        let addCardVC = AddCardBuilder().makeScene()
        
//        guard var enterCodeDS = enterCodeVC.router?.dataStore else {
//            return
//        }
        
//        passDataToEnterCode(source: enterPhoneDS, destination: &enterCodeDS)
        navigateToAddCard(source: viewController, destination: addCardVC)
    }
    
    // MARK: - Navigation
    
    private func navigateToAddCard(source: MyCardsViewController, destination: AddCardViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: - Passing data
    
//    private func passDataToEnterCode(source: EnterPhoneDataStore, destination: inout EnterCodeDataStore) {
//        destination.phoneNumber = source.phoneNumber
//    }
}
