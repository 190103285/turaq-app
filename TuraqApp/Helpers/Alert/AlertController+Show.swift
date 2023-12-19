//  Created by Илья Разумов on 29.11.2021.

import UIKit

public protocol AlertPresentableProtocol {
	
    func showAlert(title: String, message: String, image: UIImage?, actions: AlertAction...)
	
	func showAlert(title: String, message: String, image: UIImage?, actions: [AlertAction])

	func showErrorMessage(_ message: String)

    func showNoInternetConnectionAlert(handler: ((AlertAction) -> Void)?)

    func showNoInternetConnectionAlert()

    func showErrorAlert()

    func showActionSheetAlert(title: String?, message: String?, actions: [UIAlertAction])

	func hideAlert()
}

public extension AlertPresentableProtocol where Self: UIViewController {
	
	func showAlert(title: String, message: String, image: UIImage? = nil, actions: AlertAction...) {
		let alertController = AlertController.Builder()
			.addTitle(title)
			.addOkAction(handler: nil)
			.addMessage(message)
			.addImage(image)
			.addActions(actions)
			.build()
		present(alertController, animated: true, completion: nil)
	}
	
	func showAlert(title: String, message: String, image: UIImage? = nil, actions: [AlertAction]) {
		let alertController = AlertController.Builder()
			.addTitle(title)
			.addOkAction(handler: nil)
			.addMessage(message)
			.addImage(image)
			.addActions(actions)
			.build()
		present(alertController, animated: true, completion: nil)
	}
	
//	func showErrorMessage(_ message: String) {
//		let alertController = AlertController.Builder()
//			.addTitle(Localizations.strings.error.provide)
//			.addOkAction(handler: nil)
//			.addMessage(message)
//			.build()
//		present(alertController, animated: true, completion: nil)
//	}
//
//	func showErrorAlert() {
//        let alertController = AlertController.Builder()
//            .addTitle(Localizations.strings.no_internet_connection_something_wrong_title.provide)
//            .addMessage(Localizations.strings.no_internet_connection_something_wrong_message.provide)
//            .addImage(UIImage(named: "something_went_wrong"))
//            .addActions([.init(title: Localizations.strings.understand.provide, style: .main)])
//            .build()
//        present(alertController, animated: true, completion: nil)
//    }
    
//	func showNoInternetConnectionAlert(handler: ((AlertAction) -> Void)?) {
//        let alertController = AlertController.Builder()
//            .addTitle(Localizations.strings.no_internet_connection_short.provide)
//            .addMessage(Localizations.strings.no_internet_connection_no_connection_check_again.provide)
//            .addImage(UIImage(named: "no_internet_connection_old"))
//            .addActions([AlertAction.init(title: Localizations.strings.no_internet_connection_button.provide, style: .main, handler: handler)])
//            .build()
//        present(alertController, animated: true, completion: nil)
//    }
//
//	func showNoInternetConnectionAlert() {
//        let alertController = AlertController.Builder()
//            .addTitle(Localizations.strings.no_internet_connection_short.provide)
//            .addMessage(Localizations.strings.no_internet_connection_no_connection_check_again.provide)
//			.addImage(UIImage(named: "no_internet_connection_old"))
//            .addActions([AlertAction.init(title: Localizations.strings.no_internet_connection_button.provide, style: .main)])
//            .build()
//        present(alertController, animated: true, completion: nil)
//    }
    
	func hideAlert() {
        dismiss(animated: true)
    }
    
	func showActionSheetAlert(title: String?, message: String?, actions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        actions.forEach { alertController.addAction($0) }
        present(alertController, animated: true, completion: nil)
    }
}
