//
//  AddCarBuilder.swift
//  TuraqApp
//
//  Created by Akyl on 10.03.2023.
//

import UIKit

protocol AddCarBuildingLogic: AnyObject {
  func makeScene(parent: UIViewController?) -> AddCarViewController
}

final class AddCarBuilder: AddCarBuildingLogic {
  
  // MARK: - Public Methods
    
  func makeScene(parent: UIViewController? = nil) -> AddCarViewController {
    let viewController = AddCarViewController()
    
    let interactor = AddCarInteractor()
    let presenter = AddCarPresenter()
    let router = AddCarRouter()

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
