//
//  ForecastListViewModel.swift
//  KevychTestTaskSwiftUI
//
//  Created by Vitya Mandryk on 26.07.2023.
//

import CoreLocation
import Foundation
import SwiftUI

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
                        self.appError = AppError(errorString: NSLocalizedString("Unable to determine location from this text.", comment: ""))
                    case .network:
                        self.appError = AppError(errorString: NSLocalizedString("You do not appear to have a network connection.", comment: ""))
                    default:
                        self.appError = AppError(errorString: error.localizedDescription)
                    }
                    self.isLoading = false
                    
                    print(error.localizedDescription)
                }
                if let lat = placemarks?.first?.location?.coordinate.latitude,
                   let lon = placemarks?.first?.location?.coordinate.longitude {
                            apiService.getJSON(urlString: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=current,minutely,hourly,alerts&appid=59990434015e5a7c3ba4c16abe6b77a5",
                                               dateDecodingStrategy: .secondsSince1970) { (result: Result<Forecast,APIService.APIError>) in
                        switch result {
                        case .success(let forecast):
                            DispatchQueue.main.async {
                                self.isLoading = false
                                self.forecasts = forecast.daily.map { ForecastViewModel(forecast: $0, system: self.system)}
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
