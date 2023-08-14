//
//  ForecastViewModel.swift
//  KevychTestTaskSwiftUI
//
//  Created by Vitya Mandryk on 26.07.2023.
//

import Foundation

struct ForecastViewModel: Identifiable {
    let id = UUID()
    let forecast: Daily
    var system: Int
    var hourlyForecasts: [HourlyForecastViewModel]? = nil
    
    // Computed property to calculate the average temperature for the daily forecast
    var averageTemperature: String {
        let averageTemp = calculateAverageTemperature()
        return "\(Self.numberFormatter.string(for: averageTemp) ?? "0")°"
    }
    
    // Private helper function to create a DateFormatter for formatting dates
    private static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM, d"
        return dateFormatter
    }
    
    // Private helper function to create a NumberFormatter for formatting numbers
    private static var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter
    }
    
    // Private helper function to create a NumberFormatter for formatting percentages
    private static var numberFormatter2: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        return numberFormatter
    }
    
    // Function to convert temperature from Kelvin to Celsius or Fahrenheit based on the system setting
    func convert(_ temp: Double) -> Double {
        let celsius = temp - 273.5
        if system == 0 {
            return celsius
        } else {
            return celsius * 9 / 5 + 32
        }
    }
    
    // Computed property to get the formatted date string for the daily forecast
    var day: String {
        return Self.dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(forecast.dt)))
    }
    
    // Computed property to get the capitalized weather overview description
    var overview: String {
        forecast.weather[0].description.capitalized
    }
    
    // Computed property to get the formatted string for the daily high temperature
    var high: String {
        return "\(AppConstants.H) \(Self.numberFormatter.string(for: convert(forecast.temp.max)) ?? "0")°"
    }
    
    // Computed property to get the formatted string for the daily low temperature
    var low: String {
        return "\(AppConstants.L) \(Self.numberFormatter.string(for: convert(forecast.temp.min)) ?? "0")°"
    }
    
    // Computed property to get the formatted string for the probability of precipitation
    var pop: String {
        return "💧 \(Self.numberFormatter2.string(for: forecast.pop) ?? "0%")"
    }
    
    // Computed property to get the formatted string for the cloud coverage
    var clouds: String {
        return "☁️ \(forecast.clouds)%"
    }
    
    // Computed property to get the formatted string for the humidity percentage
    var humidity: String {
        return "\(AppConstants.humidity) \(forecast.humidity)%"
    }
    
    // Computed property to get the URL for the weather icon
    var weatherIconURL: URL {
        let urlString = "\(APIConstants.openWeatherMapIconURL)\(forecast.weather[0].icon)\(AppConstants.pictureFormat2x)"
        return URL(string: urlString)!
    }
    
    // Private helper function to calculate the average temperature for the daily forecast
    private func calculateAverageTemperature() -> Double {
        let minTemperature = convert(forecast.temp.min)
        let maxTemperature = convert(forecast.temp.max)
        let averageTemp = (minTemperature + maxTemperature) / 2.0
        return averageTemp
    }
}

