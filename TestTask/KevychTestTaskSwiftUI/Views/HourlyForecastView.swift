//
//  HourlyForecastView.swift
//  KevychTestTaskSwiftUI
//
//  Created by Vitya Mandryk on 06.08.2023.
//

import SwiftUI
import CoreLocation


// MARK: - HourlyForecastView
struct HourlyForecastView: View {
    @StateObject var forecastListVM = ForecastListViewModel()
    @StateObject var locationDataManager = LocationDataManager()
    var location: String
    var userLocation: CLLocation?

    var body: some View {
        NavigationView {
            if let userLocation = userLocation {
                VStack {
                    Text("Hourly Forecast")
                        .font(.title)
                        .fontWeight(.bold)
                    DailyWeatherView(location: location, userLocation: userLocation)
                    Spacer()
                    Button(action: {
                        // Open HourlyForecastListView when the "See more" button is tapped
                        NavigationLink(destination: HourlyForecastListView(location: location, userLocation: userLocation)) {
                            Text("See more")
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                    }) {
                        EmptyView()
                    }
                }
                .padding()
            } else {
                Text("Getting your location...")
                    .onAppear {
                        switch locationDataManager.locationManager.authorizationStatus {
                        case .authorizedWhenInUse:  // Location services are available.
                            // Insert code here of what should happen when Location services are authorized
                            print("Your current location is:")
                            print("Latitude: \(locationDataManager.locationManager.location?.coordinate.latitude.description ?? "Error loading")")
                            print("Longitude: \(locationDataManager.locationManager.location?.coordinate.longitude.description ?? "Error loading")")

                        case .restricted, .denied:  // Location services currently unavailable.
                            // Insert code here of what should happen when Location services are NOT authorized
                            print("Current location data was restricted or denied.")
                        case .notDetermined:        // Authorization not determined yet.
                            print("Finding your location...")
                        default:
                            break
                        }
                    }
            }
        }
    }
}
