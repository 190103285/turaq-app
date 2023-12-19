//
//  ParkingHistoryBuilder.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 10.04.2023.
//

import UIKit

protocol ParkingHistoryBuildingLogic: AnyObject {
  func makeScene(parent: UIViewController?) -> ParkingHistoryViewController
}

final class ParkingHistoryBuilder: ParkingHistoryBuildingLogic {
  
  // MARK: - Public Methods
    
  func makeScene(parent: UIViewController? = nil) -> ParkingHistoryViewController {
    let viewController = ParkingHistoryViewController()
    
    let interactor = ParkingHistoryInteractor()
    let presenter = ParkingHistoryPresenter()
    let router = ParkingHistoryRouter()

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
