//
//  MyCarsBuilder.swift
//  TuraqApp
//
//  Created by Akyl on 05.03.2023.
//

import UIKit

protocol MyCarsBuildingLogic: AnyObject {
  func makeScene(parent: UIViewController?) -> MyCarsViewController
}

final class MyCarsBuilder: MyCarsBuildingLogic {
  
  // MARK: - Public Methods
    
  func makeScene(parent: UIViewController? = nil) -> MyCarsViewController {
    let viewController = MyCarsViewController()
    
    let interactor = MyCarsInteractor()
    let presenter = MyCarsPresenter()
    let router = MyCarsRouter()

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
