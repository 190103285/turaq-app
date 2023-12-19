//
//  MyCardsPresenter.swift
//  TuraqApp
//
//  Created by Akyl on 07.03.2023.
//

import UIKit

protocol MyCardsPresentationLogic {
    func presentMyCards(_ response: [CardModel])
}

final class MyCardsPresenter: MyCardsPresentationLogic {
    
    // MARK: - Public Properties
    
    weak var viewController: MyCardsDisplayLogic?
    
    // MARK: - Private Properties
    
    //
    
    // MARK: - Presentation Logic
    
    func presentMyCards(_ response: [CardModel]) {
        let models = response.map {
            MyCardsViewCell.Params(
                id: $0.id,
                title: Formatter.formattedCardName($0.cardId),
                image: UIImage(named: Formatter.cardValidator($0.cardId).rawValue),
                isSelected: $0.selected
            )
        }
        
        
        let sections: [MyCardsFlow.Initital.SectionType] = [
            .cards(title: "My Cards".localized(), models: models),
            .addNew
        ]
        
        let model = MyCardsFlow.Initital.ViewModel(sections: sections)
        viewController?.displayMyCards(model)
    }
}
