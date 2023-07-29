//
//  ForecastViewModel.swift
//  KevychTestTaskSwiftUI
//
//  Created by Vitya Mandryk on 26.07.2023.
//

import Foundation

import Foundation

class ForecastViewModel: ObservableObject {
    let forecast: Daily?
    var system: Int = 0
    var id: UUID { UUID() }
    
    // property for hourly forecasts
    var hourly: [Weather] {
        return forecast?.weather ?? []
    }
    
    private static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM, d"
        return dateFormatter
    }
    
    private static var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter
    }
    
    private static var numberFormatter2: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        return numberFormatter
    }
    
    func convert(_ temp: Double) -> Double {
        let celsius = temp - 273.5
        if system == 0 {
            return celsius
        } else {
            return celsius * 9 / 5 + 32
        }
    }
    
    var day: String {
        if let date = forecast.flatMap({ Date(timeIntervalSince1970: TimeInterval($0.dt)) }) {
            return Self.dateFormatter.string(from: date)
        }
        return "Unknown Date"
    }
    
    var overview: String {
        guard let firstWeather = forecast?.weather.first else {
            return "Unknown"
        }
        return firstWeather.description.capitalized
    }
    
    var high: String {
        if let maxTemp = forecast?.temp.max {
            return "H: \(Self.numberFormatter.string(for: convert(maxTemp)) ?? "0")°"
        }
        return "H: N/A"
    }
    
    var low: String {
        if let minTemp = forecast?.temp.min {
            return "L: \(Self.numberFormatter.string(for: convert(minTemp)) ?? "0")°"
        }
        return "L: N/A"
    }
    
    var pop: String {
        if let popValue = forecast?.pop {
            return "💧 \(Self.numberFormatter2.string(for: popValue) ?? "0%")"
        }
        return "💧 N/A"
    }
    
    var clouds: String {
        if let cloudsValue = forecast?.clouds {
            return "☁️ \(cloudsValue)%"
        }
        return "☁️ N/A"
    }
    
    var humidity: String {
        if let humidityValue = forecast?.humidity {
            return "Humidity: \(humidityValue)%"
        }
        return "Humidity: N/A"
    }
    
    var weatherIconURL: URL? {
        guard let firstWeather = forecast?.weather.first else {
            return nil
        }
        let urlString = "https://openweathermap.org/img/wn/\(firstWeather.icon)@2x.png"
        return URL(string: urlString)
    }
    
    init(forecast: Daily? = nil) {
        self.forecast = forecast
    }
}

