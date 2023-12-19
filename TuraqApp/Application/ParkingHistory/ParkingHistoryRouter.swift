//
//  ParkingHistoryRouter.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 10.04.2023.
//

import UIKit
import FittedSheets

protocol ParkingHistoryRoutingLogic {
    func routeToInfo(_ recordId: Int)
}

protocol ParkingHistoryDataPassing {
    var dataStore: ParkingHistoryDataStore? { get }
}

final class ParkingHistoryRouter: ParkingHistoryRoutingLogic, ParkingHistoryDataPassing {
    
    // MARK: - Public Properties
    
    weak var parentController: UIViewController?
    weak var viewController: ParkingHistoryViewController?
    var dataStore: ParkingHistoryDataStore?
    
    // MARK: - Private Properties
    
    //
    
    // MARK: - Routing Logic
    
    func routeToInfo(_ recordId: Int) {
        guard let viewController = viewController,
              let dataStore else {
            fatalError("Failed route to ENTER CODE")
        }
        
        let parkingHistoryInfoVC = ParkingHistoryInfoBuilder().makeScene()
        
        guard var parkingHistoryInfoDataStore = parkingHistoryInfoVC.router?.dataStore else {
            return
        }
        
        passDataToParkingHistoryInfo(source: dataStore, destination: &parkingHistoryInfoDataStore, recordId: recordId)
        navigateToParkingHistoryInfo(source: viewController, destination: parkingHistoryInfoVC)
    }
    
    // MARK: - Navigation
    
    private func navigateToParkingHistoryInfo(source: ParkingHistoryViewController, destination: ParkingHistoryInfoViewController) {
        let options = SheetOptions(
            shouldExtendBackground: true,
            useFullScreenMode: false,
            shrinkPresentingViewController: false
        )
        let sheetController = SheetViewController(controller: destination, sizes: [.percent(0.75)], options: options) // TODO: FIX SIZES
        sheetController.allowPullingPastMaxHeight = false
        source.navigationController?.present(sheetController, animated: true)
    }
    
    // MARK: - Passing data
    
    private func passDataToParkingHistoryInfo(source: ParkingHistoryDataStore, destination: inout ParkingHistoryInfoDataStore, recordId: Int) {
        destination.history = source.history
        destination.recordId = recordId
    }
}
