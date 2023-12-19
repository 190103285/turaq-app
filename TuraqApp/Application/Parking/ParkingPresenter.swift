//
//  ParkingPresenter.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 10.04.2023.
//

import UIKit

protocol ParkingPresentationLogic {
    func presentParking(_ response: MainFlow.Status.Response)
}

final class ParkingPresenter: ParkingPresentationLogic {
    
    // MARK: - Public Properties
    
    weak var viewController: ParkingDisplayLogic?
    
    // MARK: - Presentation Logic
    
    func presentParking(_ response: MainFlow.Status.Response) {
        let viewModel = MainFlow.Status.ParkingViewModel(
            parkingId: response.parkingId,
            parkingName: response.parkingName,
            emptyPlace: response.parkingEmptyPlace
        )
        viewController?.displaySelectedParking(viewModel)
    }
}
