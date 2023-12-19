//
//  MainRouter.swift
//  TuraqApp
//
//  Created by Akyl on 28.02.2023.
//

import UIKit
import FittedSheets

protocol MainRoutingLogic {
    func routeToMenu()
    func routeToParking()
    func routeToParkingStatus()
}

protocol MainDataPassing {
    var dataStore: MainDataStore? { get set }
}

final class MainRouter: MainRoutingLogic, MainDataPassing {
    
    // MARK: - Public Properties
    
    weak var parentController: UIViewController?
    weak var viewController: MainViewController?
    var dataStore: MainDataStore?
    
    // MARK: - Private Properties
    
    //
    
    // MARK: - Routing Logic
    
    func routeToMenu() {
        guard let viewController = viewController else {
            fatalError("Failed route to Menu")
        }
        let menuVC = MenuBuilder().makeScene()
        
        navigateToMenu(source: viewController, destination: menuVC)
    }
    
    func routeToParking() {
        guard let viewController = viewController,
              let dataStore = dataStore else {
            fatalError("Failed route to Parking")
        }
        let parkingVC = ParkingBuilder().makeScene()
        
        guard var parkingDS = parkingVC.router?.dataStore else {
            return
        }
        
        passDataToParking(source: dataStore, destination: &parkingDS)
        navigateToParking(source: viewController, destination: parkingVC)
    }
    
    func routeToParkingStatus() {
        guard let viewController = viewController,
              let dataStore = dataStore else {
            fatalError("Failed route to Parking")
        }
        
        let parkingStateVC = ParkingStateBuilder().makeScene()
        
        guard var parkingStateDS = parkingStateVC.router?.dataStore else {
            return
        }
        
        passDataToParkingState(source: dataStore, destination: &parkingStateDS)
        navigateToParkingState(source: viewController, destination: parkingStateVC)
    }
    
    // MARK: - Navigation
    
    
    private func navigateToMenu(source: MainViewController, destination: MenuViewController) {
        let options = SheetOptions(
            shouldExtendBackground: true,
            useFullScreenMode: false,
            shrinkPresentingViewController: false
        )
        let sheetController = SheetViewController(controller: destination, sizes: [.intrinsic], options: options)
        sheetController.allowPullingPastMaxHeight = false
        sheetController.overlayColor = .clear
        source.navigationController?.present(sheetController, animated: true)
    }
    
    private func navigateToParking(source: MainViewController, destination: ParkingViewController) {
        destination.delegate = source
        let options = SheetOptions(
            shouldExtendBackground: true,
            useFullScreenMode: false,
            shrinkPresentingViewController: false
        )
        let sheetController = SheetViewController(controller: destination, sizes: [.intrinsic], options: options)
        sheetController.allowPullingPastMaxHeight = false
        source.navigationController?.present(sheetController, animated: true)
    }
    
    private func navigateToParkingState(source: MainViewController, destination: ParkingStateViewController) {
        destination.delegate = source
        let options = SheetOptions(
            shouldExtendBackground: true,
            useFullScreenMode: false,
            shrinkPresentingViewController: false
        )
        let sheetController = SheetViewController(controller: destination, sizes: [.intrinsic], options: options)
        sheetController.treatPullBarAsClear = true
        sheetController.allowPullingPastMaxHeight = false
        sheetController.overlayColor = .clear
        sheetController.contentBackgroundColor = .clear
        sheetController.pullBarBackgroundColor = .clear
        source.navigationController?.present(sheetController, animated: true)
    }
    
    // MARK: - Passing data
    
    private func passDataToParking(source: MainDataStore, destination: inout ParkingDataStore) {
        destination.parkingStatusResponse = source.parkingStatusResponse
    }
    
    private func passDataToParkingState(source: MainDataStore, destination: inout ParkingStateDataStore) {
        destination.selectedParkingStatus = source.parkingStatusResponse
    }
}
