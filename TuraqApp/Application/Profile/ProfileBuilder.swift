//
//  ProfileBuilder.swift
//  TuraqApp
//
//  Created by Akyl on 01.03.2023.
//

import UIKit

protocol ProfileBuildingLogic: AnyObject {
  func makeScene(parent: UIViewController?) -> ProfileViewController
}

final class ProfileBuilder: ProfileBuildingLogic {
  
  // MARK: - Public Methods
    
  func makeScene(parent: UIViewController? = nil) -> ProfileViewController {
    let viewController = ProfileViewController()
    
    let interactor = ProfileInteractor()
    let presenter = ProfilePresenter()
    let router = ProfileRouter()

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
