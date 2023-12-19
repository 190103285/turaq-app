//
//  ParkingStateBuilder.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 16.04.2023.
//

import UIKit

protocol ParkingStateBuildingLogic: AnyObject {
  func makeScene(parent: UIViewController?) -> ParkingStateViewController
}

final class ParkingStateBuilder: ParkingStateBuildingLogic {
  
  // MARK: - Public Methods
    
  func makeScene(parent: UIViewController? = nil) -> ParkingStateViewController {
    let viewController = ParkingStateViewController()
    
    let interactor = ParkingStateInteractor()
    let presenter = ParkingStatePresenter()
    let router = ParkingStateRouter()

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
