//
//  UIViewController+Extensions.swift
//  TuraqApp
//
//  Created by Akyl on 07.03.2023.
//

import UIKit

extension UIViewController: AlertPresentableProtocol {
    
    public func showErrorMessage(_ message: String) {}
    
    public func showNoInternetConnectionAlert(handler: ((AlertAction) -> Void)?) {}
    
    public func showNoInternetConnectionAlert() {}
    
    public func showErrorAlert() {}
}
