//
//  DailyForecastView.swift
//  KevychTestTaskSwiftUI
//
//  Created by Vitya Mandryk on 06.08.2023.
//

import SwiftUI

struct DailyForecastView: View {
    @StateObject var forecastListVM = ForecastListViewModel()
    @State private var showCityList = false
    var location: String

    var body: some View {
        NavigationView {
            VStack {
                SystemPicker(system: $forecastListVM.system)

                HStack {
                    LocationTextField(location: $forecastListVM.location)
                    MagnifyingGlassButton {
                        forecastListVM.getWeatherForecast()
                    }
                }
                ForecastList(forecasts: forecastListVM.forecasts)
            }
            .padding(.horizontal)
            .navigationTitle(AppConstants.citiesWeather)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    CityListButton {
                        showCityList = true
                    }
                }
            }
            .sheet(isPresented: $showCityList) {
                CityList(citySelection: $forecastListVM.location, isPresented: $showCityList)
            }
        }
    }
}
