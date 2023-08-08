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
struct HourlyForecastView: View {
    var location: String
    var forecasts: [ForecastViewModel]
    
    var body: some View {
        VStack {
            List(forecasts, id: \.id) { forecast in
                NavigationLink(destination: HourlyDetailsView(forecast: forecast)) {
                    VStack(alignment: .leading) {
                        Text("\(forecast.day)")
                        Text("Average Temp: \(forecast.averageTemperature)")
                        WebImage(url: forecast.weatherIconURL)
                    }
                }
            }
        }
        .navigationTitle("Daily Weather")
    }
}
