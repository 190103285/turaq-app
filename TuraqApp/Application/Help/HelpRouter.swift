//
//  HelpRouter.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 24.04.2023.
//

import UIKit
import SafariServices

protocol HelpRoutingLogic {
    func routeToChat()
    func routeToFaq()
    func routeToPrivacyPolicy()
    func routeToLicenseAgreement()
}

protocol HelpDataPassing {
    var dataStore: HelpDataStore? { get }
}

final class HelpRouter: HelpRoutingLogic, HelpDataPassing {
    
    // MARK: - Public Properties
    
    weak var parentController: UIViewController?
    weak var viewController: HelpViewController?
    var dataStore: HelpDataStore?
    
    // MARK: - Private Properties
    
    
    // MARK: - Routing Logic
    
    func routeToFaq() {
        guard let viewController,
              let url = URL(string: "http://100.107.195.21:8080/faq") else {
            fatalError("Failed route to FAQ")
        }
        
        let svc = SFSafariViewController(url: url)
        viewController.present(svc, animated: true, completion: nil)
    }
    
    func routeToPrivacyPolicy() {
        guard let viewController,
              let url = URL(string: "https://docs.google.com/document/d/1Jf69AR2tegRqXYOV4OJXSLZh_oQE-8h0OslTO9TlhlY/edit?usp=sharing") else {
            fatalError("Failed route to FAQ")
        }
        
        let svc = SFSafariViewController(url: url)
        viewController.present(svc, animated: true, completion: nil)
    }
    
    func routeToLicenseAgreement() {
        guard let viewController,
              let url = URL(string: "https://docs.google.com/document/d/1Z5OIuQh4KVVjdqXyYwopg_-wuYnlFg8VHwexiT5EvZk/edit?usp=sharing") else {
            fatalError("Failed route to FAQ")
        }
        
        let svc = SFSafariViewController(url: url)
        viewController.present(svc, animated: true, completion: nil)
    }
    
    func routeToChat() {
        guard let viewController,
              let url = URL(string: "https://t.me/turaqapp") else {
            fatalError("Failed route to FAQ")
        }
        
        let svc = SFSafariViewController(url: url)
        viewController.present(svc, animated: true, completion: nil)
    }
}
