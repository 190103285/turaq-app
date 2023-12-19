//
//  MenuBuilder.swift
//  TuraqApp
//
//  Created by Akyl on 12.03.2023.
//

import UIKit

protocol MenuBuildingLogic: AnyObject {
  func makeScene(parent: UIViewController?) -> MenuViewController
}

final class MenuBuilder: MenuBuildingLogic {
  
  // MARK: - Public Methods
    
  func makeScene(parent: UIViewController? = nil) -> MenuViewController {
    let viewController = MenuViewController()
    
    let interactor = MenuInteractor()
    let presenter = MenuPresenter()
    let router = MenuRouter()

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
