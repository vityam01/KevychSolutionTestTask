//
//  DailyWeatherView.swift
//  KevychTestTaskSwiftUI
//
//  Created by Vitya Mandryk on 06.08.2023.
//

import SwiftUI
import CoreLocation
import SDWebImageSwiftUI

// MARK: - DailyWeatherView

struct DailyWeatherView: View {
    @StateObject var forecastListVM = ForecastListViewModel()
    var location: String
    var userLocation: CLLocation

    var body: some View {
        if let dailyForecast = forecastListVM.forecasts.first {
            VStack {
                Text(dailyForecast.day)
                    .font(.title)
                    .fontWeight(.bold)
                WebImage(url: dailyForecast.weatherIconURL)
                    .resizable()
                    .frame(width: 50, height: 50)
                Text("Average Temperature: \(dailyForecast.averageTemperature)")
                    .font(.headline)
            }
        } else {
            Text("Loading...")
        }
    }
}
