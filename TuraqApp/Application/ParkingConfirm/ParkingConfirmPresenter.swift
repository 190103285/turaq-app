//
//  ParkingConfirmPresenter.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 12.04.2023.
//

import UIKit

protocol ParkingConfirmPresentationLogic {
    func presentParkingConfirm(_ response: ParkingConfirmFlow.Something.Response)
    func updateSelectedCar(_ response: CarModel)
    func updateSelectedCard(_ response: CardModel)
    func presentSuccessfullPark(_ parkingId: Int)
    func presentSelectedParking(_ response: MainFlow.Status.Response)
    func presentParkingError(_ message: String)
}

final class ParkingConfirmPresenter: ParkingConfirmPresentationLogic {
    
    // MARK: - Public Properties
    
    weak var viewController: ParkingConfirmDisplayLogic?
    
    // MARK: - Private Properties
    
    //
    
    // MARK: - Presentation Logic
    
    func presentParkingConfirm(_ response: ParkingConfirmFlow.Something.Response) {
        let viewModel = ParkingConfirmFlow.Something.ViewModel(
            parkingId: response.parking.id,
            parkingName: response.parking.name,
            selectedCarName: Formatter.formattedCarName(response.selectedCar),
            selectedCardName: Formatter.formattedCardName(response.selectedCard.cardId),
            selectedCardType: Formatter.cardValidator(response.selectedCard.cardId).rawValue,
            placePrice:  response.parking.price
        )
        viewController?.displayParkingConfirm(viewModel)
    }
    
    func updateSelectedCar(_ response: CarModel) {
        let viewModel = ParkingConfirmFlow.SelectedCar.ViewModel(carName: Formatter.formattedCarName(response))
        viewController?.updateSelectedCar(viewModel)
    }
    
    func updateSelectedCard(_ response: CardModel) {
        let viewModel = ParkingConfirmFlow.SelectedCard.ViewModel(cardId: Formatter.formattedCardName(response.cardId), cardType: Formatter.cardValidator(response.cardId).rawValue)
        viewController?.updateSelectedCard(viewModel)
    }
    
    func presentSuccessfullPark(_ parkingId: Int) {
        viewController?.displaySuccessfullParking(parkingId)
    }
    
    func presentSelectedParking(_ response: MainFlow.Status.Response) {
        if response.status == "TAKEN" || response.status == "BOOKED" {
            viewController?.displayParkingStatus()
        }
    }
    
    // TODO: Localization
    
    func presentParkingError(_ message: String) {
        if message == "PARKING IS FULL" {
        let viewModel = ParkingConfirmFlow.ParkingError.AlertModel(
            title: "Alas, there are no lots left".localized(),
            message: "There are no empty lots left in this zone. See the parking lots nearby".localized(),
            image: "parking_full_icon",
            buttonText: "Understand".localized()
        )
            viewController?.displayParkingError(viewModel)
        } else if message == "YOU ALREADY PARKED YOUR CAR" {
            let viewModel = ParkingConfirmFlow.ParkingError.AlertModel(
                title: "Авто уже на парковке",
                message: "Выбранная вами машина уже припаркована",
                image: "parking_full_icon",
                buttonText: "Understand".localized()
            )
            viewController?.displayParkingError(viewModel)
        } else {
            return
        }
    }
}
