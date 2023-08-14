//
//  HourlyForecastViewModel.swift
//  KevychTestTaskSwiftUI
//
//  Created by Vitya Mandryk on 06.08.2023.
//

import Foundation

// Hourly forecast view model
struct HourlyForecastViewModel: Identifiable, Hashable {
    let id = UUID()
    var time: String
    var temperature: String

    init(hourlyData: Datum) {
        if let dateTimeString = hourlyData.datetime, let date = HourlyForecastViewModel.dateFormatter.date(from: dateTimeString) {
            time = Self.timeFormatter.string(from: date)
        } else {
            time = hourlyData.datetime ?? ""
        }
        temperature = "\(Self.numberFormatter.string(for: hourlyData.temp) ?? "0")°"
    }

    private static var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }

    private static var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 0
        return formatter
    }
    
    private static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }
}
