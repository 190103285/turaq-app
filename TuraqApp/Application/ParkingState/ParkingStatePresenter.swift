//
//  ParkingStatePresenter.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 16.04.2023.
//

import UIKit

protocol ParkingStatePresentationLogic {
    func presentParkingStatus(_ response: MainFlow.Status.Response)
    func presentUnparkedAlert()
}

final class ParkingStatePresenter: ParkingStatePresentationLogic {
    
    // MARK: - Public Properties
    
    weak var viewController: ParkingStateDisplayLogic?

    // MARK: - Presentation Logic
    
    func presentParkingStatus(_ response: MainFlow.Status.Response) {
        if response.status == "TAKEN" {
            guard let endTime = response.endTime, let parkedCar = response.car else {
                return
            }
            let viewModel = MainFlow.Status.ParkingStatusViewModel(
                type: .parked,
                timeLeft: Date(timeIntervalSince1970: endTime / 1000).timeIntervalSince1970 - Date().timeIntervalSince1970,
                timerText: "Parking ends in".localized(),
                parkingId: response.parkingId,
                parkingName: response.parkingName,
                secondaryButtonTitle: "Припарковать другую",
                primaryButtonTitle: "Leave".localized(),
                carId: parkedCar.id,
                carRegNumber: parkedCar.regionalNumber ,
                carName: Formatter.formattedCarName(parkedCar)
            )
            viewController?.displayParkingStatus(viewModel)
        } else if response.status == "BOOKED" {
            guard let endTime = response.endTime else {
                return
            }
            let viewModel = MainFlow.Status.ParkingStatusViewModel(
                type: .booked,
                timeLeft: Date(timeIntervalSince1970: endTime / 1000).timeIntervalSince1970 - Date().timeIntervalSince1970,
                timerText: "Your booking expires in".localized(),
                parkingId: response.parkingId,
                parkingName: response.parkingName,
                secondaryButtonTitle: "Cancel booking".localized(),
                primaryButtonTitle: "Park".localized(),
                carId: 0,
                carRegNumber: response.car?.regionalNumber ?? "",
                carName: response.car?.model ?? ""
            )
            viewController?.displayParkingStatus(viewModel)
        }
    }
    
    func presentUnparkedAlert() {
        viewController?.displayUnparkedAlert()
    }
}
