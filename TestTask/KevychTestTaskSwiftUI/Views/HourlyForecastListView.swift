//
//  HourlyForecastListView.swift
//  KevychTestTaskSwiftUI
//
//  Created by Vitya Mandryk on 06.08.2023.
//

import SwiftUI
import CoreLocation

// MARK: - HourlyForecastListView
struct HourlyForecastListView: View {
    @StateObject var hourlyForecastListVM = HourlyForecastListViewModel()
    var location: String
    var userLocation: CLLocation

    var body: some View {
        List(hourlyForecastListVM.hourlyForecasts, id: \.self) { hourlyForecast in
            HStack {
                Text(hourlyForecast.time)
                Spacer()
                Text(hourlyForecast.temperature)
            }
        }
        .listStyle(PlainListStyle())
        .navigationTitle("Hourly Forecast")
        .onAppear {
            hourlyForecastListVM.getHourlyWeatherForecast(for: location, userLocation: userLocation)
        }
        .alert(item: $hourlyForecastListVM.appError) { appAlert in
            Alert(title: Text("Error"),
                  message: Text("""
                    \(appAlert.errorString)
                    Please try again later!
                    """
                  )
            )
        }
    }
}
