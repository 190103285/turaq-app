//
//  EnterPhoneViewController.swift
//  TuraqApp
//
//  Created by Akyl on 24.02.2023.
//

import UIKit
import CoreLocation

protocol EnterPhoneDisplayLogic: AnyObject {
    func displayEnterCode()
    func displayError()
}

final class EnterPhoneViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var interactor: EnterPhoneBusinessLogic?
    var router: (EnterPhoneRoutingLogic & EnterPhoneDataPassing)?
    
    var locationManager: CLLocationManager?
    
    // MARK: - Private Properties
    
    private lazy var enterPhoneView: EnterPhoneViewLogic = {
        let view = EnterPhoneView()
        view.delegate = self
        
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = enterPhoneView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        configureLocationManager()
    }
    
    private func configureLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        locationManager?.requestWhenInUseAuthorization()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                // Handle error
                print("Error requesting authorization: \(error.localizedDescription)")
            } else if granted {
                // User granted permission
                print("Permission granted")
            } else {
                // User denied permission
                print("Permission denied")
            }
        }
    }
}

// MARK: - Display Logic

extension EnterPhoneViewController: EnterPhoneDisplayLogic {
    
    func displayEnterCode() {
        router?.routeToEnterCode()
    }
    
    func displayError() {
        enterPhoneView.showError()
    }
}

extension EnterPhoneViewController: EnterPhoneViewDelegate {
    
    func getCodeButtonDidTap(with phoneNumber: String) {
        let request = EnterPhoneModels.GetCode.Request(phoneNumber: phoneNumber)
        interactor?.getCode(request)
    }
}

extension EnterPhoneViewController: CLLocationManagerDelegate {
    
}
