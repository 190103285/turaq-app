//
//  HelpBuilder.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 24.04.2023.
//

import UIKit

protocol HelpBuildingLogic: AnyObject {
  func makeScene(parent: UIViewController?) -> HelpViewController
}

final class HelpBuilder: HelpBuildingLogic {
  
  // MARK: - Public Methods
    
  func makeScene(parent: UIViewController? = nil) -> HelpViewController {
    let viewController = HelpViewController()
    
    let interactor = HelpInteractor()
    let presenter = HelpPresenter()
    let router = HelpRouter()

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
