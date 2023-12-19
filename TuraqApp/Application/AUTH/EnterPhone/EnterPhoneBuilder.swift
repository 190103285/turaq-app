//
//  EnterPhoneBuilder.swift
//  TuraqApp
//
//  Created by Akyl on 24.02.2023.
//

import UIKit

protocol EnterPhoneBuildingLogic: AnyObject {
    func makeScene(parent: UIViewController?) -> EnterPhoneViewController
}

final class EnterPhoneBuilder: EnterPhoneBuildingLogic {
    
    // MARK: - Public Methods
    
    func makeScene(parent: UIViewController? = nil) -> EnterPhoneViewController {
        let viewController = EnterPhoneViewController()
        
        let interactor = EnterPhoneInteractor()
        let presenter = EnterPhonePresenter()
        let router = EnterPhoneRouter()
        
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        router.parentController = parent
        router.viewController = viewController
        router.dataStore = interactor
        
        viewController.interactor = interactor
        viewController.router = router
        
        return viewController
    }
}
