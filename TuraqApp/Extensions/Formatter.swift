//
//  PhoneFormatter.swift
//  TuraqApp
//
//  Created by Akyl on 28.02.2023.
//

import Foundation

struct Formatter {
    
    enum CardType: String {
        case visa
        case mastercard
        case americanExpress
    }
    
    static let phonePattern = "+X-XXX-XXX-XX-XX"
    static let cardIdPattern = "XXXX XXXX XXXX XXXX"
    static let expirationDatePattern = "XX/XX"
    static let cvvPattern = "XXX"
    
    static func format(_ string: String, pattern: String = phonePattern) -> String {
        let numbers = string.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex // numbers iterator

        // iterate over the mask characters until the iterator of numbers ends
        for ch in pattern where index < numbers.endIndex {
            if ch == "X" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])

                // move numbers iterator to the next index
                index = numbers.index(after: index)

            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }
    
    static func formattedCardName(_ cardId: String) -> String {
        "*\(String(cardId.suffix(4)))"
    }
    
    static func formattedCarName(_ carModel: CarModel) -> String {
        "\(carModel.brand) \(carModel.model)"
    }
    
    static func cardValidator(_ cardId: String) -> CardType {
        if cardId.first == "4" {
            return .visa
        } else if cardId.first == "5" || cardId.first == "2" {
            return .mastercard
        } else {
            return .americanExpress
        }
    }
    
    static func formattedDateTime(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    static func formatTimeInterval(start: Date, end: Date) -> String {
        let timeDiff = Int(end.timeIntervalSince(start))
        let (hours, minutes) = (timeDiff / 3600, (timeDiff % 3600) / 60)
        
        if hours > 0 && minutes > 0 {
            return "\(hours) час \(minutes) мин"
        } else if hours > 0 {
            return "\(hours) час"
        } else {
            return "\(minutes) мин"
        }
    }
}
