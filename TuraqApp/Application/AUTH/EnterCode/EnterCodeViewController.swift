//
//  EnterCodeViewController.swift
//  TuraqApp
//
//  Created by Akyl on 27.02.2023.
//

import UIKit

protocol EnterCodeDisplayLogic: AnyObject {
    func displayEnterCode(_ viewModel: EnterCodeModels.EnterCode.ViewModel)
    func displayRegisterCar()
    func displayInvalidCode()
    func displayMain()
}

final class EnterCodeViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var interactor: EnterCodeBusinessLogic?
    var router: (EnterCodeRoutingLogic & EnterCodeDataPassing)?
    
    // MARK: - Private Properties
    
    private lazy var enterCodeView: EnterCodeViewLogic = {
        let view = EnterCodeView()
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
        view = enterCodeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

// MARK: - Private Methods

private extension EnterCodeViewController {
    
    func configure() {
        showEnterCode()
    }
    
    func showEnterCode() {
        interactor?.showEnterCode()
    }
}

// MARK: - Display Logic

extension EnterCodeViewController: EnterCodeDisplayLogic {
    
    func displayEnterCode(_ viewModel: EnterCodeModels.EnterCode.ViewModel) {
        enterCodeView.displayEnterCode(viewModel)
        сountdownTimerViewModel.start(remainingTime: TimeInterval(floatLiteral: 60))
    }
    
    func displayRegisterCar() {
        router?.routeToAddCar()
    }
    
    func displayInvalidCode() {
        enterCodeView.showInvalidCode()
    }
    
    func displayMain() {
        router?.routeToMain()
    }
}

// MARK: - EnterCodeViewDelegate

extension EnterCodeViewController: EnterCodeViewDelegate {
    
    func validateCode(_ code: String) {
        let request = EnterCodeModels.EnterCode.Request(otp: code)
        interactor?.checkCode(request)
    }
    
    func resendCode() {
        enterCodeView.updateResendButton(isAvailable: false)
        сountdownTimerViewModel.start(remainingTime: TimeInterval(floatLiteral: 60))
        interactor?.resendCode()
    }
}

// MARK: - CountdownTimerViewModelDelegate

extension EnterCodeViewController: CountdownTimerViewModelDelegate {
    
    func countdownTimerViewModel(_ timerViewModel: CountdownTimerViewModel, didUpdate timeString: String) {
        enterCodeView.updateResendCodeTime(timeString: timeString)
    }
    
    func countdownTimerViewModelDidStart(_ timerViewModel: CountdownTimerViewModel) {}
    
    func countdownTimerViewModelDidFinish(_ timerViewModel: CountdownTimerViewModel) {
        enterCodeView.updateResendButton(isAvailable: true)
    }
}
