//
//  HourlyDetailsView.swift
//  KevychTestTaskSwiftUI
//
//  Created by Vitya Mandryk on 08.08.2023.
//

import SwiftUI


struct HourlyDetailsView: View {
    var hourlyForecasts: [HourlyForecastViewModel]

    var body: some View {
        VStack {
            List(hourlyForecasts, id: \.id) { hourlyForecast in
                HStack {
                    Text(hourlyForecast.time)
                    Text("Temp: \(hourlyForecast.temperature)")
                }
            }
        }
        .navigationTitle("Hourly Weather")
    }
}
