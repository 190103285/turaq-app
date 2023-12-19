//
//  MyCarsPresenter.swift
//  TuraqApp
//
//  Created by Akyl on 05.03.2023.
//

import UIKit

protocol MyCarsPresentationLogic {
    func presentMyCars(_ response: [CarModel])
}

final class MyCarsPresenter: MyCarsPresentationLogic {
    
    // MARK: - Public Properties
    
    weak var viewController: MyCarsDisplayLogic?
    
    // MARK: - Private Properties
    
    //
    
    // MARK: - Presentation Logic
    
    func presentMyCars(_ response: [CarModel]) {
        let models = response.map {
            MyCarsViewCell.Params.init(
                id: $0.id,
                regionalNumber: $0.regionalNumber,
                carName: Formatter.formattedCarName($0),
                isSelected: $0.selected)
        }
        let sections: [MyCarsFlow.Initital.SectionType] = [
            .cars(title: "My Cars".localized(), models: models),
            .addNew
        ]
        
        let model = MyCarsFlow.Initital.ViewModel(sections: sections)
        viewController?.displayMyCars(model)
    }
}
