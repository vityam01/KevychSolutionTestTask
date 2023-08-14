//
//  HourlyForecastListViewModel.swift
//  KevychTestTaskSwiftUI
//
//  Created by Vitya Mandryk on 06.08.2023.
//

import Foundation
import CoreLocation

// ViewModel for hourly weather forecasts
class HourlyForecastListViewModel: ObservableObject {
    // Structure to represent an error with an identifiable ID
    struct AppError: Identifiable {
        let id = UUID().uuidString
        let errorString: String
    }

    // Published property to store hourly forecast view models
    @Published var hourlyForecasts: [HourlyForecastViewModel] = []
    // Optional published property to hold an app-level error
    var appError: AppError? = nil
    
    // Method to get hourly weather forecasts
    func getWeatherForecast(for location: CLLocation) {
        let apiService = APIService.shared
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude

        // Create the URL for the WeatherBit API request
        let urlString = "\(APIConstants.weatherBitBaseURL)?lat=\(latitude)&lon=\(longitude)&key=\(APIConstants.weatherBitAPIKey)&hours=\(AppConstants.hoursInRequest)"
        
        // Call the API service to fetch data
        apiService.getJSON(urlString: urlString, dateDecodingStrategy: .secondsSince1970) { (result: Result<HourlyForecast, APIService.APIError>) in
            switch result {
            case .success(let forecast):
                DispatchQueue.main.async {
                    // Update the hourly forecasts
                    if let hourlyData = forecast.data {
                        self.hourlyForecasts = hourlyData.map { HourlyForecastViewModel(hourlyData: $0) }
                    }
                }
            case .failure(let apiError):
                switch apiError {
                case .error(let errorString):
                    // Handle API error and set the appError property
                    self.appError = AppError(errorString: errorString)
                    print(errorString)
                }
            }
        }
    }
}
