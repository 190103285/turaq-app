//
//  ParkingStateRouter.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 16.04.2023.
//

import UIKit

protocol ParkingStateRoutingLogic {
    func routeToParkingConfirm(_ id: Int)
}

protocol ParkingStateDataPassing {
    var dataStore: ParkingStateDataStore? { get }
}

final class ParkingStateRouter: ParkingStateRoutingLogic, ParkingStateDataPassing {
    
    // MARK: - Public Properties
    
    weak var parentController: UIViewController?
    weak var viewController: ParkingStateViewController?
    var dataStore: ParkingStateDataStore?
    
    // MARK: - Private Properties
    
    //
    
    // MARK: - Routing Logic
    
    func routeToParkingConfirm(_ id: Int) {
        guard let viewController = viewController,
              let dataStore else {
            fatalError("Failed route to Profile")
        }
        let parkingConfirmVC = ParkingConfirmBuilder().makeScene()
        
        guard var parkingConfirmDataStore = parkingConfirmVC.router?.dataStore else {
            return
        }
        
        passDataToParkingConfirm(source: dataStore, destination: &parkingConfirmDataStore)
        navigateToParkingConfirm(source: viewController, destination: parkingConfirmVC)
    }
    
    // MARK: - Navigation
    
    private func navigateToParkingConfirm(source: ParkingStateViewController, destination: ParkingConfirmViewController) {
        destination.delegate = source
        destination.modalPresentationStyle = .overFullScreen
        source.present(destination, animated: true)
    }
    
    // MARK: - Passing data
    
    private func passDataToParkingConfirm(source: ParkingStateDataStore, destination: inout ParkingConfirmDataStore) {
        destination.selectedParkingId = source.selectedParkingStatus?.parkingId
    }
}
