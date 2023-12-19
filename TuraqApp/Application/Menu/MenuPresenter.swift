//
//  MenuPresenter.swift
//  TuraqApp
//
//  Created by Akyl on 12.03.2023.
//

import UIKit

protocol MenuPresentationLogic {
    func presentMenu(_ response: MenuModels.Initial.Response)
}

final class MenuPresenter: MenuPresentationLogic {
    
    // MARK: - Public Properties
    
    weak var viewController: MenuDisplayLogic?
    
    // MARK: - Presentation Logic
    
    func presentMenu(_ response: MenuModels.Initial.Response) {
        let viewModel = MenuModels.Initial.ViewModel(sections: [
            buildProfileDataSection(response),
            buildMysSection(response),
            .history,
            .help
        ])
        
        viewController?.displayMenu(viewModel)
    }
    
    func buildProfileDataSection(_ model: MenuModels.Initial.Response) -> MenuModels.Initial.ViewModel.SectionType {
        return .profile(phoneNumber: model.username)
    }
    
    func buildMysSection(_ model: MenuModels.Initial.Response) -> MenuModels.Initial.ViewModel.SectionType {
        return .mys(carModel: model.selectedCar, cardModel: model.selectedCard)
    }
}
