//
//  HourlyForecastViewModel.swift
//  KevychTestTaskSwiftUI
//
//  Created by Vitya Mandryk on 06.08.2023.
//

import Foundation

struct HourlyForecastViewModel: Identifiable, Hashable {
    let id = UUID()
    var time: String
    var temperature: String

    init(hourlyForecast: HourlyForecast.Daily) {
        time = Self.timeFormatter.string(from: hourlyForecast.dt)
        temperature = "\(Self.numberFormatter.string(for: hourlyForecast.temp) ?? "0")°"
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
}
