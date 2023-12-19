//
//  ParkingInteractor.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 10.04.2023.
//

import Foundation

protocol ParkingBusinessLogic {
    func loadParking()
}

protocol ParkingDataStore {
    var parkingStatusResponse: MainFlow.Status.Response? { get set }
}

final class ParkingInteractor: ParkingBusinessLogic, ParkingDataStore {
    
    // MARK: - Public Properties
    
    var presenter: ParkingPresentationLogic?
    lazy var worker: ParkingWorkingLogic = ParkingWorker()
    
    // MARK: - Private Properties
    
    var parkingStatusResponse: MainFlow.Status.Response?
    
    // MARK: - Business Logic
    
    func loadParking() {
        if let parkingStatusResponse {
            presenter?.presentParking(parkingStatusResponse)
        }
    }
}
