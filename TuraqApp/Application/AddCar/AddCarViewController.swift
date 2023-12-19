//
//  AddCarViewController.swift
//  TuraqApp
//
//  Created by Akyl on 10.03.2023.
//

import UIKit

protocol AddCarDisplayLogic: AnyObject {
    func displayValidatedCar()
    func dismissAddCar()
    func displayAddingError()
}

final class AddCarViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var interactor: AddCarBusinessLogic?
    var router: (AddCarRoutingLogic & AddCarDataPassing)?
    
    // MARK: - Private Properties
    
    private lazy var contentView: AddCarViewLogic = {
        let view = AddCarView()
        view.delegate = self
        
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = contentView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
}

extension AddCarViewController: AddCarViewDelegate {

    func validateCar(_ request: AddCarModels.AddCar.Request) {
        interactor?.validateCar(request)
    }
}

// MARK: - Display Logic

extension AddCarViewController: AddCarDisplayLogic {
    
    func displayValidatedCar() {
        router?.routeToAddCard()
    }
    
    func dismissAddCar() {
        showAlert(
            title: "Success".localized(),
            message: "Auto will be added within a few minutes".localized(),
            image: UIImage(named: "add_car_success"),
            actions: AlertAction(title: "OK".localized(), style: .main) { [weak self] _ in
                self?.dismiss(animated: true)
            }
        )
    }
    
    func displayAddingError() {
        showAlert(
            title: "An error has occurred".localized(),
            message: "Double-check the car data and try again".localized(),
            image: UIImage(named: "car_adding_error"),
            actions: AlertAction(title: "Try again".localized(), style: .main)
        )
    }
}
