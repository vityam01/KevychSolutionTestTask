//
//  DailyViewModel.swift
//  KevychTestTaskSwiftUI
//
//  Created by Vitya Mandryk on 29.07.2023.
//

import Foundation


class DailyViewModel: Identifiable {
    let id = UUID()
    let day: String
    let averageTemperature: Double
    let hourlyForecasts: [HourlyViewModel]

    init(dailyForecast: Daily) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        self.day = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(dailyForecast.dt)))
        self.averageTemperature = dailyForecast.temp.day
        
        // Map hourly weather data from Weather objects and pass the Daily object as well
        self.hourlyForecasts = dailyForecast.weather.map { HourlyViewModel(daily: dailyForecast, weather: $0) }
    }
}
