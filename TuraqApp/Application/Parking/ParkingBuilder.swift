//
//  ParkingBuilder.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 10.04.2023.
//

import UIKit

protocol ParkingBuildingLogic: AnyObject {
  func makeScene(parent: UIViewController?) -> ParkingViewController
}

final class ParkingBuilder: ParkingBuildingLogic {
  
  // MARK: - Public Methods
    
  func makeScene(parent: UIViewController? = nil) -> ParkingViewController {
    let viewController = ParkingViewController()
    
    let interactor = ParkingInteractor()
    let presenter = ParkingPresenter()
    let router = ParkingRouter()

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
