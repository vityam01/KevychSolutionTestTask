//
//  WeatherListView.swift
//  KevychTestTaskSwiftUI
//
//  Created by Vitya Mandryk on 31.07.2023.
//

import SwiftUI
import SDWebImageSwiftUI


struct WeatherListView: View {
    @ObservedObject var forecastListVM: ForecastListViewModel
    @Binding var showList: Bool
    
    var body: some View {
        VStack {
            List(citiesUkraine, id: \.id) { city in
                Button(action: {
                    forecastListVM.getWeatherForecast(for: city)
                    showList.toggle()
                }) {
                    Text(city.name)
                }
            }
            .listStyle(PlainListStyle())
            
            ForEach(forecastListVM.forecasts, id: \.day) { day in
                VStack(alignment: .leading) {
                    Text(day.day)
                        .fontWeight(.bold)
                    HStack {
                        WebImage(url: day.weatherIconURL)
                            .resizable()
                            .placeholder {
                                Image(systemName: "hourglass")
                            }
                            .scaledToFit()
                            .frame(width: 75)
                        VStack(alignment: .leading) {
                            Text(day.overview)
                                .font(.title2)
                            HStack {
                                Text(day.high)
                                Text(day.low)
                            }
                            HStack {
                                Text(day.clouds)
                                Text(day.pop)
                            }
                            Text(day.humidity)
                        }
                    }
                }
            }
        }
    }
}

