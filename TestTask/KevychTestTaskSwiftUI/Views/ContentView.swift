//
//  ContentView.swift
//  KevychTestTaskSwiftUI
//
//  Created by Vitya Mandryk on 26.07.2023.
//

import SDWebImageSwiftUI
import SwiftUI
import CoreLocation


// MARK: - ContentView
struct ContentView: View {
    @StateObject var locationDataManager = LocationDataManager()
    @StateObject var forecastListVM = HourlyForecastListViewModel()
    @State private var showCityList = false

    var body: some View {
        NavigationView {
            TabView {
                NavigationView {
                    HourlyForecastListView(location: "\(locationDataManager.authorizationStatus == .authorizedWhenInUse ? AppConstants.authorized : AppConstants.notAuthorized)",
                                           hourlyForecasts: forecastListVM.hourlyForecasts)
                    .navigationBarTitle(AppConstants.hourlyForecast)
                }
                .tabItem {
                    Image(systemName: AppConstants.clock)
                    Text(AppConstants.averageDaily)
                }
                DailyForecastView(location: "\(locationDataManager.locationManager.location?.coordinate.latitude ?? 0.0), \(locationDataManager.locationManager.location?.coordinate.longitude ?? 0.0)")
                    .tabItem {
                        Image(systemName: AppConstants.map)
                        Text(AppConstants.city)
                    }
            }
            .onAppear {
                fetchWeatherForecast()
            }
        }
    }
}

extension ContentView {
    func fetchWeatherForecast() {
        let userLocation = locationDataManager.locationManager.location ?? CLLocation(latitude: 0.0, longitude: 0.0)
        forecastListVM.getWeatherForecast(for: userLocation)
    }
}
