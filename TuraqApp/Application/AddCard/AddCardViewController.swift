//
//  AddCardViewController.swift
//  TuraqApp
//
//  Created by Akyl on 10.03.2023.
//

import UIKit

protocol AddCardDisplayLogic: AnyObject {
    func displayValidatedCard()
    func dismissAddCard()
    func displayAddingError()
}

final class AddCardViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var interactor: AddCardBusinessLogic?
    var router: (AddCardRoutingLogic & AddCardDataPassing)?
    
    // MARK: - Private Properties
    
    private lazy var contentView: AddCardViewLogic = {
        let view = AddCardView()
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

extension AddCardViewController: AddCardViewDelegate {
    
    func validateCard(_ request: AddCardModels.AddCard.Request) {
        interactor?.validateCard(request)
    }
}

// MARK: - Display Logic

extension AddCardViewController: AddCardDisplayLogic {
    
    func displayValidatedCard() {
        router?.routeToMain()
    }
    
    func dismissAddCard() {
        showAlert(
            title: "Success".localized(),
            message: "The card will be added within a few minutes".localized(),
            image: UIImage(named: "add_card_success"),
            actions: AlertAction(title: "OK".localized(), style: .main) { [weak self] _ in
                self?.dismiss(animated: true)
            }
        )
    }
    
    func displayAddingError() {
        showAlert(
            title: "An error has occurred".localized(),
            message: "Double-check the card details and try again".localized(),
            image: UIImage(named: "adding_card_error_icon"),
            actions: AlertAction(title: "Try again".localized(), style: .main)
        )
    }
}
