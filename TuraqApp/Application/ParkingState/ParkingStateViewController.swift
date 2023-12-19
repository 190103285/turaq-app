//
//  ParkingStateViewController.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 16.04.2023.
//

import UIKit

protocol ParkingStateDisplayLogic: AnyObject {
    func displayParkingStatus(_ viewModel: MainFlow.Status.ParkingStatusViewModel)
    func displayUnparkedAlert()
}

protocol ParkingStateViewControllerDelegate: AnyObject {
    func parkingStateViewControllerDelegateSuccessfullParking(_ vc: ParkingStateViewController, _ parkingId: Int)
}

final class ParkingStateViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var interactor: ParkingStateBusinessLogic?
    var router: (ParkingStateRoutingLogic & ParkingStateDataPassing)?
    weak var delegate: ParkingStateViewControllerDelegate?
    
    // MARK: - Private Properties
    
    private lazy var contentView: ParkingStateViewLogic = {
        let view = ParkingStateView()
        view.delegate = self
        
        return view
    }()
    
    private lazy var сountdownTimerViewModel: CountdownTimerViewModel = {
        let viewModel = CountdownTimerViewModel()
        viewModel.delegate = self
        
        return viewModel
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
        interactor?.loadStatus()
    }
}

// MARK: - Display Logic

extension ParkingStateViewController: ParkingStateDisplayLogic {
    
    func displayParkingStatus(_ viewModel: MainFlow.Status.ParkingStatusViewModel) {
        сountdownTimerViewModel.start(remainingTime: TimeInterval(floatLiteral: viewModel.timeLeft))
        contentView.bind(with: viewModel)
    }
    
    // TODO: Localization
    
    func displayUnparkedAlert() {
        showAlert(
            title: "Парковка закончилась",
            message: "Приходите еще",
            image: nil,
            actions: AlertAction(title: "Закрыть", style: .main) { [weak self] _ in
                self?.dismiss(animated: true)
            }
        )
    }
}

extension ParkingStateViewController: ParkingStateViewDelegate {
    
    func cancelBooking(with id: Int) {
        showAlert(
            title: "Attention".localized(),
            message: "Canceling a booking, will lose your parking zone".localized(),
            image: nil,
            actions: AlertAction(title: "Confirm".localized(), style: .main) { [weak self] _ in
                self?.interactor?.unbook(id)
                self?.dismiss(animated: true)
            },
            AlertAction(title: "Cancel".localized(), style: .default)
        )
    }
    
    func park(with id: Int) {
        router?.routeToParkingConfirm(id)
    }
    
    func leaveDidTap(_ request: ParkingStateModels.Leave.Request) {
        showAlert(
            title: "Attention".localized(),
            message: "Are you sure you want to leave?".localized(),
            image: nil,
            actions: AlertAction(title: "Confirm".localized(), style: .main) { [weak self] _ in
                self?.interactor?.unpark(request)
                self?.dismiss(animated: true)
            },
            AlertAction(title: "Cancel".localized(), style: .default)
        )
    }
    
    func hideDidTap() {
        dismiss(animated: true)
    }
}

// MARK: - CountdownTimerViewModelDelegate

extension ParkingStateViewController: CountdownTimerViewModelDelegate {
    
    func countdownTimerViewModel(_ timerViewModel: CountdownTimerViewModel, didUpdate timeString: String) {
        contentView.updateTimerTime(timeString: timeString)
    }
    
    func countdownTimerViewModelDidStart(_ timerViewModel: CountdownTimerViewModel) {}
    
    func countdownTimerViewModelDidFinish(_ timerViewModel: CountdownTimerViewModel) {}
}

extension ParkingStateViewController: ParkingConfirmViewControllerDelegate {
    
    func parkingConfirmViewControllerDelegateSuccessfullParking(_ vc: ParkingConfirmViewController, _ parkingId: Int) {
        dismiss(animated: true) { [weak self] in
            self?.delegate?.parkingStateViewControllerDelegateSuccessfullParking(self ?? ParkingStateViewController(), parkingId)
        }
    }
}
