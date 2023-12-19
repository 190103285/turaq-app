//
//  ProfileRouter.swift
//  TuraqApp
//
//  Created by Akyl on 01.03.2023.
//

import UIKit

protocol ProfileRoutingLogic {
    func routeToSelectLanguage()
    func routeToAuth()
    func routeToSettings()
}

protocol ProfileDataPassing {
    var dataStore: ProfileDataStore? { get }
}

final class ProfileRouter: ProfileRoutingLogic, ProfileDataPassing {
    
    // MARK: - Public Properties
    
    weak var parentController: UIViewController?
    weak var viewController: ProfileViewController?
    var dataStore: ProfileDataStore?
    
    // MARK: - Routing Logic
    
    func routeToSelectLanguage() {
        guard let viewController = viewController else {
            fatalError("Failed route to ENTER CODE")
        }
        let myCarsVC = MyCarsBuilder().makeScene()
        
        navigateToMyCars(source: viewController, destination: myCarsVC)
    }
    
    func routeToAuth() {
        guard let viewController = viewController else {
            fatalError("Failed route to ENTER CODE")
        }
        
        let authVC = EnterPhoneBuilder().makeScene()
        
        navigateToAuth(source: viewController, destination: authVC)
    }
    
    func routeToSettings() {
        if let bundleIdentifier = Bundle.main.bundleIdentifier,
            let settingsURL = URL(string: UIApplication.openSettingsURLString + bundleIdentifier) {
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
        }
    }
    
    // MARK: - Navigation
    
    private func navigateToMyCars(source: ProfileViewController, destination: MyCarsViewController) {
        if let sheet = destination.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        source.present(destination, animated: true)
    }
    
    private func navigateToAuth(source: ProfileViewController, destination: EnterPhoneViewController) {
        let nav = BaseNavigationController(rootViewController: destination)
        nav.modalPresentationStyle = .overFullScreen
        source.present(nav, animated: false)
    }
    
    // MARK: - Passing data
}
