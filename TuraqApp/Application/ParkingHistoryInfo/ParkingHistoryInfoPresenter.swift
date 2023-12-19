//
//  ParkingHistoryInfoPresenter.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 12.04.2023.
//

import UIKit

protocol ParkingHistoryInfoPresentationLogic {
    func presentInfo(_ response: ParkingHistoryModels.History)
}

final class ParkingHistoryInfoPresenter: ParkingHistoryInfoPresentationLogic {
    
    // MARK: - Public Properties
    
    weak var viewController: ParkingHistoryInfoDisplayLogic?
    
    // MARK: - Presentation Logic
    
    func presentInfo(_ response: ParkingHistoryModels.History) {
        let viewModel = ParkingHistoryInfoModels.Info.ViewModel( sections: [ buildTimeSection(response: response),
                                                                             buildCarSection(response: response),
                                                                             buildPaymentSection(response: response),
                                                                             ],
                                                                 headerModel: buildPriceSection(response: response)
        )
        
        viewController?.displayInfo(viewModel)
    }
}

private extension ParkingHistoryInfoPresenter {
    
    func buildTimeSection(response: ParkingHistoryModels.History) -> ParkingHistoryInfoModels.Info.RowType {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .positional
        let formattedString = formatter.string(from: TimeInterval((response.parkingEndTime - response.parkingStartTime) / 1000))
        let model = ParkingHistoryInfoModels.Info.TimeModel(
            title: "Start time".localized(),
            subtitle: "Time in".localized(),
            startTime: dateFormatter.string(from: Date(timeIntervalSince1970: response.parkingStartTime / 1000)),
            timeOnParking: formattedString ?? ""
        )
        return .time(model: model)
    }
    
    func buildCarSection(response: ParkingHistoryModels.History) -> ParkingHistoryInfoModels.Info.RowType {
        let model = ParkingHistoryInfoModels.Info.CarModel(
            carTitle: "Transport".localized(),
            carRegNumber: response.car.regionalNumber,
            carName: Formatter.formattedCarName(response.car)
        )
        return .car(model: model)
    }
    
    func buildPaymentSection(response: ParkingHistoryModels.History) -> ParkingHistoryInfoModels.Info.RowType {
        let model = ParkingHistoryInfoModels.Info.PaymentModel(
            paymentTitle: "Payment method".localized(),
            paymentType: Formatter.cardValidator(response.paymentCard.cardId).rawValue,
            paymentCardId: Formatter.formattedCardName(response.paymentCard.cardId)
        )
        return .payment(model: model)
    }
    
    func buildPriceSection(response: ParkingHistoryModels.History) -> ParkingHistoryInfoModels.Info.ReceiptModel {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM"
        dateFormatter.locale = Locale(identifier: "kk_KZ")
        let date = Date(timeIntervalSince1970: response.parkingStartTime / 1000)
        let startDate = dateFormatter.string(from: date)
        
        let header = "\(response.parking.name), \(startDate)"
        
        return ParkingHistoryInfoModels.Info.ReceiptModel(
            header: header,
            initialPrice: "\(String(response.totalCost)) ₸",
            penaltyPrice: "0 ₸",
            totalPrice: "\(String(response.totalCost)) ₸"
        )
    }
}
