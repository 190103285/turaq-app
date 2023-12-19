//
//  MyCarsRouter.swift
//  TuraqApp
//
//  Created by Akyl on 05.03.2023.
//

import UIKit

protocol MyCarsRoutingLogic {
    func routeToAddCar()
}

protocol MyCarsDataPassing {
  var dataStore: MyCarsDataStore? { get }
}

final class MyCarsRouter: MyCarsRoutingLogic, MyCarsDataPassing {

  // MARK: - Public Properties

  weak var parentController: UIViewController?
  weak var viewController: MyCarsViewController?
  var dataStore: MyCarsDataStore?
  
  // MARK: - Private Properties
  
  //

    // MARK: - Routing Logic
    
    func routeToAddCar() {
        guard let viewController = viewController else {
            fatalError("Failed route to Add Car")
        }
        let addCarVC = AddCarBuilder().makeScene()
        navigateToAddCar(source: viewController, destination: addCarVC)
    }
    
    // MARK: - Navigation
    
    private func navigateToAddCar(source: MyCarsViewController, destination: AddCarViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: - Passing data
}
