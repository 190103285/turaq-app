//  Created by Akyl Temirgaliyev on 12.04.2023.

import UIKit

protocol ParkingConfirmDisplayLogic: AnyObject {
    func displayParkingConfirm(_ viewModel: ParkingConfirmFlow.Something.ViewModel)
    func updateSelectedCar(_ viewModel: ParkingConfirmFlow.SelectedCar.ViewModel)
    func updateSelectedCard(_ viewModel: ParkingConfirmFlow.SelectedCard.ViewModel)
    func displayParkingStatus()
    func displaySuccessfullParking(_ parkingId: Int)
    func displayParkingError(_ viewModel: ParkingConfirmFlow.ParkingError.AlertModel)
}

protocol ParkingConfirmViewControllerDelegate: AnyObject {
    func parkingConfirmViewControllerDelegateSuccessfullParking(_ vc: ParkingConfirmViewController, _ parkingId: Int)
}

final class ParkingConfirmViewController: UIViewController {
    
    // MARK: - Public Properties
    
    weak var delegate: ParkingConfirmViewControllerDelegate?
    var interactor: ParkingConfirmBusinessLogic?
    var router: (ParkingConfirmRoutingLogic & ParkingConfirmDataPassing)?
    
    // MARK: - Private Properties
    
    private lazy var contentView: ParkingConfirmViewLogic = {
        let view = ParkingConfirmView()
        view.delegate = self
        
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        interactor?.loadParkingInfo()
    }
}

// MARK: - Display Logic

extension ParkingConfirmViewController: ParkingConfirmDisplayLogic {
    
    func displayParkingError(_ viewModel: ParkingConfirmFlow.ParkingError.AlertModel) {
        showAlert(
            title: viewModel.title,
            message: viewModel.message,
            image: UIImage(named: viewModel.image),
            actions: AlertAction(title: viewModel.buttonText, style: .main)
        )
    }
    
    func displaySuccessfullParking(_ parkingId: Int) {
        showAlert(
            title: "The payment was successful!".localized(),
            message: "",
            image: UIImage(named: "payment_success"),
            actions: AlertAction(title: "Go back to the main page".localized(), style: .main) { [weak self] _ in
                self?.dismiss(animated: true) {
                    self?.delegate?.parkingConfirmViewControllerDelegateSuccessfullParking(self ?? ParkingConfirmViewController(), parkingId)
                }
            }
        )
    }
    
    func displayParkingStatus() {
        router?.routeToParkingState()
    }
    
    func displayParkingConfirm(_ viewModel: ParkingConfirmFlow.Something.ViewModel) {
        contentView.bind(with: viewModel)
    }
    
    func updateSelectedCar(_ viewModel: ParkingConfirmFlow.SelectedCar.ViewModel) {
        contentView.updateSelectedCar(viewModel)
    }
    
    func updateSelectedCard(_ viewModel: ParkingConfirmFlow.SelectedCard.ViewModel) {
        contentView.updateSelectedCard(viewModel)
    }
}

// MARK: - ParkingConfirmViewDelegate

extension ParkingConfirmViewController: ParkingConfirmViewDelegate {
    
    func parkingConfirmViewConfirmDidTap(_ view: ParkingConfirmView, request: ParkingConfirmFlow.Something.Request) {
        interactor?.park(request)
    }
    
    func parkingConfirmViewSelectCarDidTap(_ view: ParkingConfirmView) {
        router?.routeToSelectCar()
        interactor?.loadSelectedCar()
    }
    
    func parkingConfirmViewSelectCardDidTap(_ view: ParkingConfirmView) {
        router?.routeToSelectCard()
        interactor?.loadSelectedCard()
    }
    
    func parkingConfirmViewBackButtonDidTap(_ view: ParkingConfirmView) {
        dismiss(animated: true)
    }
}
