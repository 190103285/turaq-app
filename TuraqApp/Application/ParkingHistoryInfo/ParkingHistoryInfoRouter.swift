//
//  ParkingHistoryInfoRouter.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 12.04.2023.
//

import UIKit
import SafariServices

protocol ParkingHistoryInfoRoutingLogic {
    func routeToChat()
}

protocol ParkingHistoryInfoDataPassing {
  var dataStore: ParkingHistoryInfoDataStore? { get }
}

final class ParkingHistoryInfoRouter: ParkingHistoryInfoRoutingLogic, ParkingHistoryInfoDataPassing {

  // MARK: - Public Properties

  weak var parentController: UIViewController?
  weak var viewController: ParkingHistoryInfoViewController?
  var dataStore: ParkingHistoryInfoDataStore?
  
  // MARK: - Private Properties
  
  //

  // MARK: - Routing Logic
  
    func routeToChat() {
        guard let viewController,
              let url = URL(string: "https://t.me/turaqapp") else {
            fatalError("Failed route to FAQ")
        }
        
        let svc = SFSafariViewController(url: url)
        viewController.present(svc, animated: true)
    }
}
