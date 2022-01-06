//
//  DateExtension.swift
//  CovidStatsITA
//
//  Created by Matteo Visotto on 24/08/2020.
//  Copyright © 2020 Matteo Visotto. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    static func getDateForCurrentLocale(date: Date, withDataFormat dataFormat: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Calendar.current.locale
        formatter.timeZone = Calendar.current.timeZone
        formatter.dateFormat = dataFormat
        return formatter.string(from: date)
    }
}
