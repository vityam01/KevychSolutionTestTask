//
//  HourlyForecastListViewModel.swift
//  KevychTestTaskSwiftUI
//
//  Created by Vitya Mandryk on 06.08.2023.
//

import Foundation
import CoreLocation

class HourlyForecastListViewModel: ObservableObject {
    struct AppError: Identifiable {
        let id = UUID().uuidString
        let errorString: String
    }

    @Published var hourlyForecasts: [HourlyForecastViewModel] = []
    var appError: AppError? = nil

    func getHourlyWeatherForecast(for location: String, userLocation: CLLocation) {
        let apiService = APIService.shared
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude

        apiService.getJSON(urlString: "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&exclude=current,minutely,daily,alerts&appid=59990434015e5a7c3ba4c16abe6b77a5",
                           dateDecodingStrategy: .secondsSince1970) { (result: Result<HourlyForecast, APIService.APIError>) in
            switch result {
            case .success(let forecast):
                DispatchQueue.main.async {
                    self.hourlyForecasts = forecast.hourly.map { HourlyForecastViewModel(hourlyForecast: $0) }
                }
            case .failure(let apiError):
                switch apiError {
                case .error(let errorString):
                    self.appError = AppError(errorString: errorString)
                    print(errorString)
                }
            }
        }
    }
}
