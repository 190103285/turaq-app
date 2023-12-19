//
//  ParkingConfirmRouter.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 12.04.2023.
//

import UIKit
import FittedSheets

protocol ParkingConfirmRoutingLogic {
    func routeToSelectCar()
    func routeToSelectCard()
    func routeToParkingState()
}

protocol ParkingConfirmDataPassing {
    var dataStore: ParkingConfirmDataStore? { get }
}

final class ParkingConfirmRouter: ParkingConfirmRoutingLogic, ParkingConfirmDataPassing {
    
    // MARK: - Public Properties
    
    weak var parentController: UIViewController?
    weak var viewController: ParkingConfirmViewController?
    var dataStore: ParkingConfirmDataStore?
    
    // MARK: - Routing Logic
    
    func routeToSelectCar() {
        guard let viewController = viewController else {
            fatalError("Failed route to MyCars")
        }
        let myCarsVC = MyCarsBuilder().makeScene()
        navigateToMyCars(source: viewController, destination: myCarsVC)
    }
    
    func routeToSelectCard() {
        guard let viewController = viewController else {
            fatalError("Failed route to MyCards")
        }
        let myCardsVC = MyCardsBuilder().makeScene()
        navigateToMyCards(source: viewController, destination: myCardsVC)
    }
    
    func routeToParkingState() {
        guard let viewController,
              let dataStore else {
            fatalError("Failed route to MyCards")
        }
        let parkingStatusVC = ParkingStateBuilder().makeScene()
        
        guard var parkingStateDS = parkingStatusVC.router?.dataStore else {
            return
        }

        passDataToParkingStatus(source: dataStore, destination: &parkingStateDS)
        navigateToParkingStatus(source: viewController, destination: parkingStatusVC)
    }
    
    // MARK: - Navigation
    
    func navigateToMyCars(source: ParkingConfirmViewController, destination: MyCarsViewController) {
        destination.modalPresentationStyle = .overFullScreen
        source.present(destination, animated: true)
    }
    
    func navigateToMyCards(source: ParkingConfirmViewController, destination: MyCardsViewController) {
        destination.modalPresentationStyle = .overFullScreen
        source.present(destination, animated: true)
    }
    
    func navigateToParkingStatus(source: ParkingConfirmViewController, destination: ParkingStateViewController) {
        destination.modalPresentationStyle = .overCurrentContext
        source.present(destination, animated: true)
    }
    
    // MARK: - Passing data
    
    private func passDataToParkingStatus(source: ParkingConfirmDataStore, destination: inout ParkingStateDataStore) {
        destination.selectedParkingStatus = source.selectedParking
    }
}
