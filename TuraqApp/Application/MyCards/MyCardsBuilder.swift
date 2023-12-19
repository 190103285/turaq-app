//
//  MyCardsBuilder.swift
//  TuraqApp
//
//  Created by Akyl on 07.03.2023.
//

import UIKit

protocol MyCardsBuildingLogic: AnyObject {
    func makeScene(parent: UIViewController?) -> MyCardsViewController
}

final class MyCardsBuilder: MyCardsBuildingLogic {
    
    // MARK: - Public Methods
    
    func makeScene(parent: UIViewController? = nil) -> MyCardsViewController {
        let viewController = MyCardsViewController()
        
        let interactor = MyCardsInteractor()
        let presenter = MyCardsPresenter()
        let router = MyCardsRouter()
        
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
