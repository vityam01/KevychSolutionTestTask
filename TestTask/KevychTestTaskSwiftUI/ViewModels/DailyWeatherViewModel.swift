//
//  DailyWeatherViewModel.swift
//  KevychTestTaskSwiftUI
//
//  Created by Vitya Mandryk on 10.08.2023.
//

import Foundation


struct DailyWeatherViewModel: Identifiable {
    let id = UUID()
    let date: Date
    let averageTemp: Double
    let hourlyWeather: [HourlyWeather]
}
