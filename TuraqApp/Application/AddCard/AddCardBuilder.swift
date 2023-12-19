//
//  AddCardBuilder.swift
//  TuraqApp
//
//  Created by Akyl on 10.03.2023.
//

import UIKit

protocol AddCardBuildingLogic: AnyObject {
  func makeScene(parent: UIViewController?) -> AddCardViewController
}

final class AddCardBuilder: AddCardBuildingLogic {
  
  // MARK: - Public Methods
    
  func makeScene(parent: UIViewController? = nil) -> AddCardViewController {
    let viewController = AddCardViewController()
    
    let interactor = AddCardInteractor()
    let presenter = AddCardPresenter()
    let router = AddCardRouter()

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
