//
//  ParkingConfirmBuilder.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 12.04.2023.
//

import UIKit

protocol ParkingConfirmBuildingLogic: AnyObject {
  func makeScene(parent: UIViewController?) -> ParkingConfirmViewController
}

final class ParkingConfirmBuilder: ParkingConfirmBuildingLogic {
  
  // MARK: - Public Methods
    
  func makeScene(parent: UIViewController? = nil) -> ParkingConfirmViewController {
    let viewController = ParkingConfirmViewController()
    
    let interactor = ParkingConfirmInteractor()
    let presenter = ParkingConfirmPresenter()
    let router = ParkingConfirmRouter()

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
