//
//  ParkingHistoryPresenter.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 10.04.2023.
//

import UIKit

protocol ParkingHistoryPresentationLogic {
    func presentHistory(_ response: [ParkingHistoryModels.History])
}

final class ParkingHistoryPresenter: ParkingHistoryPresentationLogic {
    
    // MARK: - Public Properties
    
    weak var viewController: ParkingHistoryDisplayLogic?
    
    // MARK: - Presentation Logic
    
    func presentHistory(_ response: [ParkingHistoryModels.History]) {
        viewController?.displayHistory(groupHistoryByMonth(history: response).sections)
    }
    
    private func groupHistoryByMonth(history: [ParkingHistoryModels.History]) -> ParkingHistoryModels.Something.ViewModel {
        guard !history.isEmpty else {
            return ParkingHistoryModels.Something.ViewModel(sections: [])
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        dateFormatter.locale = Locale(identifier: "kk_KZ")
        
        // Create a dictionary to group the histories by month
        var historiesByMonth: [String: [ParkingHistoryModels.History]] = [:]
        for record in history {
            let date = Date(timeIntervalSince1970: record.parkingStartTime / 1000)
            let monthString = dateFormatter.string(from: date)
            if historiesByMonth[monthString] == nil {
                historiesByMonth[monthString] = [record]
            } else {
                historiesByMonth[monthString]?.append(record)
            }
        }
        
        var sections: [ParkingHistoryModels.Something.Section] = []
        for (month, histories) in historiesByMonth {
            let records = histories.map {
                ParkingHistoryModels.Something.Record(
                    id: $0.id,
                    dateText: formatDate(timestamp: $0.parkingStartTime / 1000),
                    parkingName: $0.parking.name
                )
            }
            let section = ParkingHistoryModels.Something.Section(sectionTitle: month, records: records)
            sections.append(section)
        }
        
        // Sort the sections by date, most recent first
        sections.sort { section1, section2 in
            let date1 = dateFormatter.date(from: section1.sectionTitle)!
            let date2 = dateFormatter.date(from: section2.sectionTitle)!
            return date1 > date2
        }
        
        return ParkingHistoryModels.Something.ViewModel(sections: sections)
    }
    
    private func formatDate(timestamp: Double) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy, HH:mm"
        dateFormatter.locale = Locale(identifier: "kk_KZ")
        let date = Date(timeIntervalSince1970: timestamp)
        return dateFormatter.string(from: date)
    }
}
