//
//  WeatherForecastViewModel.swift
//  KevychTestTaskSwiftUI
//
//  Created by Vitya Mandryk on 29.07.2023.
//

import Foundation
import Combine

class WeatherForecastViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var dailyForecasts = [DailyViewModel]()
    @Published var forecasts: [ForecastViewModel] = []
    @Published var appError: AppError?

    // Function to fetch weather data
    func fetchWeatherData(latitude: Double, longitude: Double) {
        isLoading = true
        let apiService = APIService.shared
        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&exclude=current,minutely,hourly,alerts&appid=59990434015e5a7c3ba4c16abe6b77a5"
        apiService.getJSON(urlString: urlString, dateDecodingStrategy: .secondsSince1970) { (result: Result<Forecast, APIService.APIError>) in
            switch result {
            case .success(let forecast):
                DispatchQueue.main.async {
                    self.isLoading = false
                    // Map the daily forecasts to the ViewModel and store them
                    self.dailyForecasts = forecast.daily.map { DailyViewModel(dailyForecast: $0) }
                }
            case .failure(let apiError):
                switch apiError {
                case .error(let errorString):
                    self.isLoading = false
                    self.appError = AppError(errorString: errorString)
                    print(errorString)
                }
            }
        }
    }
}
