//
//  ForecastListViewModel.swift
//  KevychTestTaskSwiftUI
//
//  Created by Vitya Mandryk on 26.07.2023.
//

import CoreLocation
import Foundation
import SwiftUI

// ViewModel for daily weather forecast
class ForecastListViewModel: ObservableObject {
    // Structure to represent an error with an identifiable ID
    struct AppError: Identifiable {
        let id = UUID().uuidString
        let errorString: String
    }

    // Published property to store the list of forecast view models
    @Published var forecasts: [ForecastViewModel] = []
    // Optional published property to hold an app-level error
    var appError: AppError? = nil
    // Published property to track loading status
    @Published var isLoading: Bool = false
    // Property to store the user-selected location in the app storage
    @AppStorage("location") var storageLocation: String = ""
    // Published property to hold the current location
    @Published var location = ""
    // Property to store the user-selected temperature system (0: Celsius, 1: Fahrenheit)
    @AppStorage("system") var system: Int = 0 {
        // When the temperature system changes, update all forecast view models
        didSet {
            for i in 0..<forecasts.count {
                forecasts[i].system = system
            }
        }
    }
    
    // Initializer for the ForecastListViewModel
    init() {
        // Initialize the location with the value stored in app storage
        location = storageLocation
        // Fetch weather forecast for the current location
        getWeatherForecast()
    }
    
    // Method to get weather forecast for a given location
    func getWeatherForecast(for location: CLLocation) {
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude

        // Create the URL for the OpenWeatherMap API request
        let urlString = "\(APIConstants.openWeatherMapBaseURL)?lat=\(lat)&lon=\(lon)&exclude=current,minutely,hourly,alerts&appid=\(APIConstants.openWeatherMapAPIKey)"
        
        let apiService = APIService.shared
        // Call the API service to fetch data
        apiService.getJSON(urlString: urlString, dateDecodingStrategy: .secondsSince1970) { (result: Result<Forecast, APIService.APIError>) in
            switch result {
            case .success(let forecast):
                DispatchQueue.main.async {
                    // Update the daily forecasts
                    self.forecasts = forecast.daily.map { ForecastViewModel(forecast: $0, system: 9, hourlyForecasts: nil) }
                }
            case .failure(let apiError):
                DispatchQueue.main.async {
                    self.forecasts = []
                }
                print(apiError.localizedDescription)
            }
        }
    }
    
    // Method to get weather forecast for the current location
    func getWeatherForecast() {
        storageLocation = location
        UIApplication.shared.endEditing()
        if location == "" {
            forecasts = []
        } else {
            isLoading = true
            let apiService = APIService.shared
            CLGeocoder().geocodeAddressString(location) { (placemarks, error) in
                if let error = error as? CLError {
                    switch error.code {
                    case .locationUnknown, .geocodeFoundNoResult, .geocodeFoundPartialResult:
                        self.appError = AppError(errorString: NSLocalizedString(AppConstants.appError1, comment: ""))
                    case .network:
                        self.appError = AppError(errorString: NSLocalizedString(AppConstants.appError2, comment: ""))
                    default:
                        self.appError = AppError(errorString: error.localizedDescription)
                    }
                    self.isLoading = false
                    print(error.localizedDescription)
                }
                if let lat = placemarks?.first?.location?.coordinate.latitude,
                   let lon = placemarks?.first?.location?.coordinate.longitude {
                    let urlString = "\(APIConstants.openWeatherMapBaseURL)?lat=\(lat)&lon=\(lon)&exclude=current,minutely,hourly,alerts&appid=\(APIConstants.openWeatherMapAPIKey)"
                    apiService.getJSON(urlString: urlString, dateDecodingStrategy: .secondsSince1970) { (result: Result<Forecast, APIService.APIError>) in
                        switch result {
                        case .success(let forecast):
                            DispatchQueue.main.async {
                                self.isLoading = false
                                // Update the daily forecasts
                                self.forecasts = forecast.daily.map { ForecastViewModel(forecast: $0, system: self.system, hourlyForecasts: nil) }
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
        }
    }
}
