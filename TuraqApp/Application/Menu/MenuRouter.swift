//
//  MenuRouter.swift
//  TuraqApp
//
//  Created by Akyl on 12.03.2023.
//

import UIKit
import FittedSheets

protocol MenuRoutingLogic {
    func routeToProfile()
    func routeToMyCars()
    func routeToMyCards()
    func routeToHistory()
    func routeToHelp()
}

protocol MenuDataPassing {
    var dataStore: MenuDataStore? { get }
}

final class MenuRouter: MenuDataPassing {
    
    // MARK: - Public Properties
    
    weak var parentController: UIViewController?
    weak var viewController: MenuViewController?
    var dataStore: MenuDataStore?
    
    // MARK: - Routing Logic
    
    func routeToProfile() {
        guard let viewController = viewController else {
            fatalError("Failed route to Profile")
        }
        let profileVC = ProfileBuilder().makeScene()
        navigateToProfile(source: viewController, destination: profileVC)
    }
    
    func routeToMyCars() {
        guard let viewController = viewController else {
            fatalError("Failed route to MyCars")
        }
        let myCarsVC = MyCarsBuilder().makeScene()
        navigateToMyCars(source: viewController, destination: myCarsVC)
    }
    
    func routeToMyCards() {
        guard let viewController = viewController else {
            fatalError("Failed route to MyCards")
        }
        let myCardsVC = MyCardsBuilder().makeScene()
        navigateToMyCards(source: viewController, destination: myCardsVC)
    }
    
    func routeToHistory() {
        guard let viewController = viewController else {
            fatalError("Failed route to Parking History")
        }
        let history = ParkingHistoryBuilder().makeScene()
        navigateToHistory(source: viewController, destination: history)
    }
    
    func routeToHelp() {
        guard let viewController = viewController else {
            fatalError("Failed route to Parking History")
        }
        let help = HelpBuilder().makeScene()
        navigateToHelp(source: viewController, destination: help)
    }
}

// MARK: - MenuRoutingLogic

extension MenuRouter: MenuRoutingLogic {
    
    func navigateToProfile(source: MenuViewController, destination: ProfileViewController) {
        let nav = BaseNavigationController(rootViewController: destination)
        nav.modalPresentationStyle = .overFullScreen
        source.present(nav, animated: true)
    }
    
    func navigateToMyCars(source: MenuViewController, destination: MyCarsViewController) {
        let nav = BaseNavigationController(rootViewController: destination)
        nav.modalPresentationStyle = .overFullScreen
        source.present(nav, animated: true)
    }
    
    func navigateToMyCards(source: MenuViewController, destination: MyCardsViewController) {
        let nav = BaseNavigationController(rootViewController: destination)
        nav.modalPresentationStyle = .overFullScreen
        source.present(nav, animated: true)
    }
    
    func navigateToHistory(source: MenuViewController, destination: ParkingHistoryViewController) {
        let nav = BaseNavigationController(rootViewController: destination)
        nav.modalPresentationStyle = .overFullScreen
        source.present(nav, animated: true)
    }
    
    func navigateToHelp(source: MenuViewController, destination: HelpViewController) {
        let nav = BaseNavigationController(rootViewController: destination)
        nav.modalPresentationStyle = .overFullScreen
        source.present(nav, animated: true)
    }
}
