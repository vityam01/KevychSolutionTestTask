//
//  ForecastListViewModel.swift
//  KevychTestTaskSwiftUI
//
//  Created by Vitya Mandryk on 26.07.2023.
//

import CoreLocation
import Combine
import Foundation
import SwiftUI

class ForecastListViewModel: ObservableObject {
    
    //MARK: AppError
    struct AppError: Identifiable {
        let id = UUID().uuidString
        let errorString: String
    }
    
    //MARK: Varaibales/ Constants
    private var cancellable: AnyCancellable?
    var appError: AppError? = nil
    
    //MARK: @Published
    @Published var forecasts: [ForecastViewModel] = []
    @Published var selectedCity: City?
    @Published var isLoading: Bool = false
    @Published var location = ""
    
    //MARK: @AppStorage
    @AppStorage("location") var storageLocation: String = ""

    @AppStorage("system") var system: Int = 0 {
        didSet {
            for i in 0..<forecasts.count {
                forecasts[i].system = system
            }
        }
    }
    
    //MARK: init()
    init() {
        location = storageLocation
            setupSearch()
            getWeatherForecast()
    }
    
    func setupSearch() {
        cancellable = $location
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] location in
                self?.getWeatherForecast()
            }
    }
    
    
    private func fetchWeatherData(latitude: Double, longitude: Double) {
            isLoading = true
            let apiService = APIService.shared
            let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&exclude=current,minutely,hourly,alerts&appid=59990434015e5a7c3ba4c16abe6b77a5"
            apiService.getJSON(urlString: urlString, dateDecodingStrategy: .secondsSince1970) { (result: Result<Forecast, APIService.APIError>) in
                switch result {
                case .success(let forecast):
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.forecasts = forecast.daily.map { ForecastViewModel(forecast: $0/*, system: self.system*/) }
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
        
    func getWeatherForecast(for city: City? = nil, location: String? = nil) {
            if let selectedCity = city {
                fetchWeatherData(latitude: selectedCity.latitude, longitude: selectedCity.longitude)
            } else if let location = location, !location.isEmpty {
                self.location = location
                UIApplication.shared.endEditing() // better to replace it to enother place
                
                isLoading = true
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
                        self.fetchWeatherData(latitude: lat, longitude: lon)
                    }
                }
            } else {
                forecasts = []
            }
        }
}
