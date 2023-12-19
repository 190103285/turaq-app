//
//  BookingBuilder.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 12.04.2023.
//

import UIKit

protocol BookingBuildingLogic: AnyObject {
  func makeScene(parent: UIViewController?) -> BookingViewController
}

final class BookingBuilder: BookingBuildingLogic {
  
  // MARK: - Public Methods
    
  func makeScene(parent: UIViewController? = nil) -> BookingViewController {
    let viewController = BookingViewController()
    
    let interactor = BookingInteractor()
    let presenter = BookingPresenter()
    let router = BookingRouter()

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
