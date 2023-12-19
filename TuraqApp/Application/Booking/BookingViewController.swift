//
//  BookingViewController.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 12.04.2023.
//

import UIKit

protocol BookingDisplayLogic: AnyObject {
    func displayBookedView(_ parkingId: Int)
    func displayBookingError(_ viewModel: ParkingConfirmFlow.ParkingError.AlertModel)
}

protocol BookingViewControllerDelegate: AnyObject {
    func bookingViewControllerSuccessfullBooking(_ vc: BookingViewController, _ parkingId: Int)
}

final class BookingViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var interactor: BookingBusinessLogic?
    var router: (BookingRoutingLogic & BookingDataPassing)?
    weak var delegate: BookingViewControllerDelegate?
    
    private lazy var contentView: BookingViewLogic = {
        let view = BookingView()
        view.delegate = self
        
        return view
    }()
    
    // MARK: - Private Properties
    
    //
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Public Methods
    
    //
    
    // MARK: - Requests
    
    //
    
    // MARK: - Private Methods
    
    private func configure() {
        
    }
    
    // MARK: - UI Actions
    
    //
}

// MARK: - Display Logic

extension BookingViewController: BookingDisplayLogic {
    
    func displayBookedView(_ parkingId: Int) {
        dismiss(animated: true) { [weak self] in
            self?.delegate?.bookingViewControllerSuccessfullBooking(self ?? BookingViewController(), parkingId)
        }
    }
    
    func displayBookingError(_ viewModel: ParkingConfirmFlow.ParkingError.AlertModel) {
        showAlert(
            title: viewModel.title,
            message: viewModel.message,
            image: UIImage(named: viewModel.image),
            actions: AlertAction(title: viewModel.buttonText, style: .main)
        )
    }
}

extension BookingViewController: BookingViewDelegate {
    
    func confirmDidTap(with type: BookingView.BookingType) {
        interactor?.book(type: type)
    }
}
