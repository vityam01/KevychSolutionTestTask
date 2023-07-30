//
//  WeatherForecastListView.swift
//  KevychTestTaskSwiftUI
//
//  Created by Vitya Mandryk on 30.07.2023.
//

import SwiftUI
import SDWebImageSwiftUI


struct WeatherForecastListView: View {
    @ObservedObject private var forecastVM: ForecastListViewModel
    let userLatitude: Double
    let userLongitude: Double

    init(userLatitude: Double, userLongitude: Double) {
        self.userLatitude = userLatitude
        self.userLongitude = userLongitude
        self._forecastVM = ObservedObject(wrappedValue: ForecastListViewModel())
        // ^^^^^^^^^^^ Use @ObservedObject wrapper for forecastVM
    }

    var body: some View {
        if forecastVM.isLoading {
            ProgressView("Fetching Weather")
                .padding()
        } else if let error = forecastVM.appError {
            Text("Error: \(error.errorString)")
                .foregroundColor(.red)
        } else {
            List(forecastVM.forecasts, id: \.day) { day in
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
            .listStyle(PlainListStyle())
        }
    }
}


//struct WeatherForecastListView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeatherForecastListView(userLatitude: <#Double#>, userLongitude: <#Double#>)
//    }
//}
