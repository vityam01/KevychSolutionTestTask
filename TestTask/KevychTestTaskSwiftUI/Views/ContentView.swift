//
//  ContentView.swift
//  KevychTestTaskSwiftUI
//
//  Created by Vitya Mandryk on 26.07.2023.
//

import SDWebImageSwiftUI
import SwiftUI
import CoreLocation


// MARK: - ContentView
struct ContentView: View {
    @StateObject var locationDataManager = LocationDataManager()
    @StateObject var forecastListVM = ForecastListViewModel()
    @State private var showCityList = false

    var body: some View {
        TabView {
            HourlyForecastView(location: "\(locationDataManager.locationManager.location)")
                .tabItem {
                    Image(systemName: "clock")
                    Text("Hourly")
                }
            DailyForecastView(location: "\(locationDataManager.locationManager.location)")
                .tabItem {
                    Image(systemName: "sun.max")
                    Text("Daily")
                }
        }
    }
}

