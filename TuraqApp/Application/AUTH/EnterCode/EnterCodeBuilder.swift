//
//  EnterCodeBuilder.swift
//  TuraqApp
//
//  Created by Akyl on 27.02.2023.
//

import UIKit

protocol EnterCodeBuildingLogic: AnyObject {
    func makeScene(parent: UIViewController?) -> EnterCodeViewController
}

final class EnterCodeBuilder: EnterCodeBuildingLogic {
    
    // MARK: - Public Methods
    
    func makeScene(parent: UIViewController? = nil) -> EnterCodeViewController {
        let viewController = EnterCodeViewController()
        
        let interactor = EnterCodeInteractor()
        let presenter = EnterCodePresenter()
        let router = EnterCodeRouter()
        
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
