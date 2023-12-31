//
//  HourlyForecastView.swift
//  KevychTestTaskSwiftUI
//
//  Created by Vitya Mandryk on 06.08.2023.
//

import SwiftUI
import CoreLocation
import SDWebImageSwiftUI


// MARK: - HourlyForecastView
struct HourlyForecastListView: View {
    var location: String
    var hourlyForecasts: [HourlyForecastViewModel] // Use the ViewModel

    var body: some View {
        List(hourlyForecasts, id: \.id) { forecast in
            NavigationLink(destination: Text("Hourly details here")) { // Replace with the desired HourlyDetailsView when Data will be able for parsing
                VStack(alignment: .leading) {
                    Text("\(AppConstants.date) \(forecast.time)")
                    Text("\(AppConstants.temperature) \(forecast.temperature)")
                }
            }
        }
        .navigationTitle(AppConstants.averageDailyTemperature)
        .navigationBarTitleDisplayMode(.inline)
    }
}
