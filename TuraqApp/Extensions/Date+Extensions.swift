//
//  Date+Extensions.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 19.04.2023.
//

import Foundation

extension Date {
    static func diffrence(lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}

extension TimeInterval{

        func stringFromTimeInterval() -> String {

            let time = NSInteger(self)

//            let ms = Int((self.truncatingRemainder(dividingBy: 1)) * 1000)
            let seconds = time % 60
            let minutes = (time / 60) % 60
            let hours = (time / 3600)

            return String(format: "%0.2d:%0.2d", hours, minutes)

        }
    }
