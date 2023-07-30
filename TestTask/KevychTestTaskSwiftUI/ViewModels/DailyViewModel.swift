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


class WeatherDetailViewModel: ObservableObject {
    @Published var weatherDetail: WeatherDetail?
    @Published var isLoading = false
    @Published var appError: AppError?
    
    func fetchWeatherDetail() {
        // Replace this with your logic to fetch weather details for the selected city
        // and update the `weatherDetail`, `isLoading`, and `appError` properties accordingly.
        // For demonstration purposes, we'll set a sample weather detail.
        let sampleWeatherDetail = WeatherDetail(name: "Sample City",
                                                overview: "Partly cloudy with some sun.",
                                                weatherIconURL: URL(string: "https://example.com/sample-icon.png")!,
                                                high: "28°C",
                                                low: "20°C",
                                                clouds: "50%",
                                                pop: "20%",
                                                humidity: "70%")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.weatherDetail = sampleWeatherDetail
            self.isLoading = false
        }
    }
}

struct WeatherDetail: Identifiable {
    let id = UUID()
    let name: String
    let overview: String
    let weatherIconURL: URL
    let high: String
    let low: String
    let clouds: String
    let pop: String
    let humidity: String
}
