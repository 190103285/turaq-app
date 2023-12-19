//
//  HelpInteractor.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 24.04.2023.
//

import Foundation

protocol HelpBusinessLogic {
    func getHelp()
}

protocol HelpDataStore {
    
}

final class HelpInteractor: HelpBusinessLogic, HelpDataStore {
    
    // MARK: - Public Properties
    
    var presenter: HelpPresentationLogic?
    lazy var worker: HelpWorkingLogic = HelpWorker()
    
    // MARK: - Private Properties
    
    //
    
    // MARK: - Business Logic
    
    func getHelp() {
        presenter?.presentHelp()
    }
}
