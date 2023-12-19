//
//  MainPresenter.swift
//  TuraqApp
//
//  Created by Akyl on 28.02.2023.
//

import UIKit
import CoreLocation

protocol MainPresentationLogic {
    func presentParkings(_ response: [ParkingModel])
    func presentSelectedParking(_ response: MainFlow.Status.Response)
}

final class MainPresenter: MainPresentationLogic {
    
    // MARK: - Public Properties
    
    weak var viewController: MainDisplayLogic?
    
    // MARK: - Private Properties
    
    // MARK: - Presentation Logic
    
    func presentParkings(_ response: [ParkingModel]) {
        let parkings = response.map {
            MainFlow.RenderedParkingModel(
                id: $0.id,
                name: $0.name,
                coordinates: CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude),
                capacity: $0.capacity,
                places: $0.places
            )
        }
        viewController?.displayParkings(MainFlow.Something.ViewModel(parkings: parkings))
    }
    
    func presentSelectedParking(_ response: MainFlow.Status.Response) {
        if response.status == "TAKEN" || response.status == "BOOKED" {
            viewController?.displaySelectedParkingStatus()
        } else {
            viewController?.displaySelectedParking()
        }
    }
}
