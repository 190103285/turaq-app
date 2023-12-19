//  Created by Akyl Temirgaliyev on 10.04.2023.

import UIKit

protocol ParkingDisplayLogic: AnyObject {
    func displaySelectedParking(_ viewModel: MainFlow.Status.ParkingViewModel)
}

protocol ParkingViewControllerDelegate: AnyObject {
    func parkingViewControllerDelegateSuccessfullyAtParking(_ vc: ParkingViewController, _ parkingId: Int)
}

final class ParkingViewController: UIViewController {
    
    // MARK: - Public Properties
    
    weak var delegate: ParkingViewControllerDelegate?
    var interactor: ParkingBusinessLogic?
    var router: (ParkingRoutingLogic & ParkingDataPassing)?
    
    // MARK: - Private Properties
    
    private lazy var contentView: ParkingViewLogic = {
        let view = ParkingView()
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
        interactor?.loadParking()
    }
}

// MARK: - Display Logic

extension ParkingViewController: ParkingDisplayLogic {
    
    func displaySelectedParking(_ viewModel: MainFlow.Status.ParkingViewModel) {
        contentView.bind(with: viewModel)
    }
}

// MARK: - ParkingViewDelegate

extension ParkingViewController: ParkingViewDelegate {
    
    func bookButtonTap(_ id: Int) {
        router?.routeToBooking(id)
    }
    
    func parkButtonTap() {
        router?.routeToParkingConfirm()
    }
}

// MARK: - ParkingConfirmViewControllerDelegate

extension ParkingViewController: ParkingConfirmViewControllerDelegate, BookingViewControllerDelegate {
    
    func bookingViewControllerSuccessfullBooking(_ vc: BookingViewController, _ parkingId: Int) {
        dismiss(animated: true) { [weak self] in
            self?.delegate?.parkingViewControllerDelegateSuccessfullyAtParking(self ?? ParkingViewController(), parkingId)
        }
    }
    
    func parkingConfirmViewControllerDelegateSuccessfullParking(_ vc: ParkingConfirmViewController, _ parkingId: Int) {
        dismiss(animated: true) { [weak self] in
            self?.delegate?.parkingViewControllerDelegateSuccessfullyAtParking(self ?? ParkingViewController(), parkingId)
        }
    }
}
