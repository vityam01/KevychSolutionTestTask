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

       var body: some View {
           List(dailyForecast.hourlyForecasts, id: \.self) { hourlyForecast in
               // Display hourly weather data for the selected day
               Text("\(hourlyForecast.time): \(hourlyForecast.temperature, specifier: "%.1f")°C")
           }
       }
}

//struct HourlyWeatherView_Previews: PreviewProvider {
//    static var previews: some View {
//        HourlyWeatherView()
//    }
//}

