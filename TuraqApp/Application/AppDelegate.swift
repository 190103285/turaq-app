//
//  AppDelegate.swift
//  TuraqApp
//
//  Created by Akyl on 22.02.2023.
//

import UIKit
import GoogleMaps
import SkeletonView

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        InitialConfigurator.configure()
        GMSServices.provideAPIKey("AIzaSyA6ehlvNj5oMveCAhWnmOIlyJj6WhZi8bE")
        
        window = UIWindow()
        window?.rootViewController = BaseNavigationController(nibName: nil, bundle: nil)
        startApp()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func startRegistration() -> UIViewController {
        let enterPhoneVC = EnterPhoneBuilder().makeScene()
        let navigationController = BaseNavigationController(rootViewController: enterPhoneVC)
        
        return navigationController
    }
    
    func startMain() -> UIViewController {
        let mainVC = MainBuilder().makeScene()
        let navigationController = UINavigationController(rootViewController: mainVC)
        
        return navigationController
    }
    
    func startApp() {
        guard let token = KeychainHelper.standard.read(service: "token", account: "ios", type: String.self) else {
            self.window?.rootViewController = startRegistration()
            return
        }
        
        MainInteractor.isTokenExpired(token: token) { [weak self] isNotTokenExpired in
            self?.window?.rootViewController = isNotTokenExpired ? self?.startMain() : self?.startRegistration()
        }
    }
}
