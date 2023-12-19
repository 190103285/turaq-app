//
//  BookingRouter.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 12.04.2023.
//

import UIKit

protocol BookingRoutingLogic {

}

protocol BookingDataPassing {
  var dataStore: BookingDataStore? { get }
}

final class BookingRouter: BookingRoutingLogic, BookingDataPassing {

  // MARK: - Public Properties

  weak var parentController: UIViewController?
  weak var viewController: BookingViewController?
  var dataStore: BookingDataStore?
  
  // MARK: - Private Properties
  
  //

  // MARK: - Routing Logic
  
  //

  // MARK: - Navigation
  
  //

  // MARK: - Passing data
  
  //
}
