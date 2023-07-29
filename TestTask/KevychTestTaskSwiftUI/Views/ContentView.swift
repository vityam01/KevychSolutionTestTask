//
//  ContentView.swift
//  KevychTestTaskSwiftUI
//
//  Created by Vitya Mandryk on 26.07.2023.
//

import SwiftUI
import SDWebImageSwiftUI
import CoreLocation
import Combine


struct WeatherForecastView: View {
    @ObservedObject private var weatherVM = WeatherForecastViewModel()
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        VStack {
            if let userLatitude = locationManager.userLatitude, let userLongitude = locationManager.userLongitude {
                WeatherForecastListView(userLatitude: userLatitude, userLongitude: userLongitude)
            } else {
                ProgressView("Fetching Location")
                    .padding()
            }
        }
        .onAppear {
            locationManager.startUpdatingLocation()
        }
        .alert(item: $weatherVM.appError) { appAlert in
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

struct ContentView: View {
    @StateObject private var forecastListVM = ForecastListViewModel()
    @State private var searchText = ""
    @State private var showList = false
    @State private var selectedIndex = 0
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedIndex) {
                // First Tab: WeatherForecastView
                WeatherForecastView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    .tag(0)
                
                // Second Tab: Weather List View
                VStack {
                    // Weather list view content here
                    
                    // Show the list of cities only when the second tab is selected
                    if selectedIndex == 1 {
                        List(citiesUkraine, id: \.id) { city in
                            Button(action: {
                                forecastListVM.getWeatherForecast(for: city)
                                showList.toggle()
                            }) {
                                Text(city.name)
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
                    
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
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Weather")
                }
                .tag(1)
                .navigationTitle("Weather")
            }
            .accentColor(.blue)
            .background(Color(.systemBackground))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        withAnimation {
                            searchText = ""
                            showList.toggle()
                        }
                    }) {
                        Image(systemName: "list.bullet")
                            .font(.title2)
                    }
                }
            }
            .alert(item: $forecastListVM.appError) { appAlert in
                Alert(title: Text("Error"),
                      message: Text("""
                           \(appAlert.errorString)
                           Please try again later!
                           """
                                   )
                )
            }
            .onChange(of: showList) { newValue in
                if newValue {
                    forecastListVM.getWeatherForecast()
                }
            }
            .onAppear {
                forecastListVM.getWeatherForecast()
            }
            .overlay(
                Group {
                    if forecastListVM.isLoading {
                        ZStack {
                            Color(.white)
                                .opacity(0.3)
                                .ignoresSafeArea()
                            ProgressView("Fetching Weather")
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color(.systemBackground))
                                )
                                .shadow(radius: 10)
                        }
                    }
                }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}