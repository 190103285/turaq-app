//
//  BookingPresenter.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 12.04.2023.
//

import UIKit

protocol BookingPresentationLogic {
    func presentBookedView(_ parkingId: Int)
    func presentBookingError(_ message: String)
}

final class BookingPresenter: BookingPresentationLogic {
    
    // MARK: - Public Properties
    
    weak var viewController: BookingDisplayLogic?
    
    // MARK: - Private Properties
    
    //
    
    // MARK: - Presentation Logic
    
    func presentBookedView(_ parkingId: Int) {
        viewController?.displayBookedView(parkingId)
    }
    
    func presentBookingError(_ message: String) {
        if message == "PARKING IS FULL" {
        let viewModel = ParkingConfirmFlow.ParkingError.AlertModel(
            title: "Нет парковочных мест",
            message: "Увы в данной зоне не осталось свободных парковочных мест",
            image: "payment_success",
            buttonText: "Понятно"
        )
            viewController?.displayBookingError(viewModel)
        } else if message == "YOU ALREADY PARKED YOUR CAR" {
            let viewModel = ParkingConfirmFlow.ParkingError.AlertModel(
                title: "Авто уже на парковке",
                message: "Выбранная вами машина уже припаркована",
                image: "payment_success",
                buttonText: "Понятно"
            )
            viewController?.displayBookingError(viewModel)
        } else {
            return
        }
    }
}
