//
//  ParkingRouter.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 10.04.2023.
//

import UIKit
import FittedSheets

protocol ParkingRoutingLogic {
    func routeToBooking(_ id: Int)
    func routeToParkingConfirm()
}

protocol ParkingDataPassing {
    var dataStore: ParkingDataStore? { get }
}

final class ParkingRouter: ParkingRoutingLogic, ParkingDataPassing {
    
    // MARK: - Public Properties
    
    weak var parentController: UIViewController?
    weak var viewController: ParkingViewController?
    var dataStore: ParkingDataStore?
    
    // MARK: - Routing Logic
    
    func routeToBooking(_ id: Int) {
        guard let viewController = viewController,
              let dataStore else {
            fatalError("Failed route to Profile")
        }
        let bookingVC = BookingBuilder().makeScene()
        
        guard var bookingDataStore = bookingVC.router?.dataStore else {
            return
        }
        passDataToBooking(source: dataStore, destination: &bookingDataStore, parkingId: id)
        navigateToBooking(source: viewController, destination: bookingVC)
    }
    
    func routeToParkingConfirm() {
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
    
    private func navigateToBooking(source: ParkingViewController, destination: BookingViewController) {
        destination.delegate = source
        let options = SheetOptions(
            shouldExtendBackground: true,
            useFullScreenMode: false,
            shrinkPresentingViewController: false
        )
        let sheetController = SheetViewController(controller: destination, sizes: [.intrinsic], options: options)
        sheetController.allowPullingPastMaxHeight = false
        source.present(sheetController, animated: true)
    }
    
    private func navigateToParkingConfirm(source: ParkingViewController, destination: ParkingConfirmViewController) {
        destination.delegate = source
        destination.modalPresentationStyle = .overFullScreen
        source.present(destination, animated: true)
    }
    
    // MARK: - Passing data
    
    private func passDataToParkingConfirm(source: ParkingDataStore, destination: inout ParkingConfirmDataStore) {
        destination.selectedParking = source.parkingStatusResponse
        destination.selectedParkingId = source.parkingStatusResponse?.parkingId
    }
    
    private func passDataToBooking(source: ParkingDataStore, destination: inout BookingDataStore, parkingId: Int) {
        destination.parkingId = parkingId
    }
}
