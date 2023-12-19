//
//  ParkingHistoryInfoBuilder.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 12.04.2023.
//

import UIKit

protocol ParkingHistoryInfoBuildingLogic: AnyObject {
  func makeScene(parent: UIViewController?) -> ParkingHistoryInfoViewController
}

final class ParkingHistoryInfoBuilder: ParkingHistoryInfoBuildingLogic {
  
  // MARK: - Public Methods
    
  func makeScene(parent: UIViewController? = nil) -> ParkingHistoryInfoViewController {
    let viewController = ParkingHistoryInfoViewController()
    
    let interactor = ParkingHistoryInfoInteractor()
    let presenter = ParkingHistoryInfoPresenter()
    let router = ParkingHistoryInfoRouter()

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
