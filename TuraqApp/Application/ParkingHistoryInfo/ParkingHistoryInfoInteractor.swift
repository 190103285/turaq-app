//
//  ParkingHistoryInfoInteractor.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 12.04.2023.
//

import Foundation

protocol ParkingHistoryInfoBusinessLogic {
    func loadRecord()
}

protocol ParkingHistoryInfoDataStore {
    var history: [ParkingHistoryModels.History] { get set }
    var recordId: Int? { get set }
}

final class ParkingHistoryInfoInteractor: ParkingHistoryInfoBusinessLogic, ParkingHistoryInfoDataStore {
    
    // MARK: - Public Properties
    
    var presenter: ParkingHistoryInfoPresentationLogic?
    lazy var worker: ParkingHistoryInfoWorkingLogic = ParkingHistoryInfoWorker()
    
    var history: [ParkingHistoryModels.History] = []
    var recordId: Int?
    
    
    // MARK: - Private Properties
    
    private var selectedRecord: ParkingHistoryModels.History?
    
    // MARK: - Business Logic
    
    func loadRecord() {
        guard let recordId else {
            return
        }
        
        history.forEach { [weak self] in
            if $0.id == recordId {
                self?.selectedRecord = $0
            }
        }
        
        guard let selectedRecord else {
            return
        }
        
        presenter?.presentInfo(selectedRecord)
    }
}
