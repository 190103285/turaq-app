//
//  MainBuilder.swift
//  TuraqApp
//
//  Created by Akyl on 28.02.2023.
//

import UIKit

protocol MainBuildingLogic: AnyObject {
  func makeScene(parent: UIViewController?) -> MainViewController
}

final class MainBuilder: MainBuildingLogic {
  
  // MARK: - Public Methods
    
  func makeScene(parent: UIViewController? = nil) -> MainViewController {
    let viewController = MainViewController()
    
    let interactor = MainInteractor()
    let presenter = MainPresenter()
    let router = MainRouter()

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
