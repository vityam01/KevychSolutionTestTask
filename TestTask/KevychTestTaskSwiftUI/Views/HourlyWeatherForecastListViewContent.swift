//
//  HourlyWeatherForecastListViewContent.swift
//  KevychTestTaskSwiftUI
//
//  Created by Vitya Mandryk on 31.07.2023.
//

import SwiftUI

struct WeatherForecastListViewContent: View {
    let userLatitude: Double
    let userLongitude: Double

    var body: some View {
        VStack {
            WeatherForecastListView(userLatitude: userLatitude, userLongitude: userLongitude)
                .navigationTitle("Weather Forecast")
        }
    }
}

