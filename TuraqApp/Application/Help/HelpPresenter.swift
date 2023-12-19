//
//  HelpPresenter.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 24.04.2023.
//

import UIKit

protocol HelpPresentationLogic {
    func presentHelp()
}

final class HelpPresenter: HelpPresentationLogic {
    
    // MARK: - Public Properties
    
    weak var viewController: HelpDisplayLogic?
    
    // MARK: - Private Properties
    
    //
    
    // MARK: - Presentation Logic
    
    func presentHelp() {
        let viewModel = HelpModels.Initital.ViewModel(
            sections: [
                .info(types: [.privacyPolicy, .licenseAgreement, .faq]),
                .chat(title: "Support Chat".localized())
            ]
        )
        
        viewController?.displayHelp(viewModel)
    }
}
