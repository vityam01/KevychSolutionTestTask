//
//  HourlyWeatherView.swift
//  KevychTestTaskSwiftUI
//
//  Created by Vitya Mandryk on 29.07.2023.
//

import SwiftUI
import SDWebImageSwiftUI


struct HourlyWeatherView: View {
    let dailyForecast: DailyViewModel

    @State private var isHourlyListPresented = false

    var body: some View {
        VStack {
            Text("Average Daily Weather: \(dailyForecast.averageTemperature, specifier: "%.1f")°C")
                .padding()
                .onTapGesture {
                    isHourlyListPresented = true
                }

            if isHourlyListPresented {
                List(dailyForecast.hourlyForecasts, id: \.self) { hourlyForecast in
                    Text("\(hourlyForecast.time): \(hourlyForecast.temperature, specifier: "%.1f")°C")
                }
            }
        }
        .navigationTitle("Hourly Weather")
    }
}


