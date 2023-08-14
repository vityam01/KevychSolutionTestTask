//
//  ViewComponents.swift
//  KevychTestTaskSwiftUI
//
//  Created by Vitya Mandryk on 06.08.2023.
//

import SwiftUI
import SDWebImageSwiftUI

// MARK: - Components

struct SystemPicker: View {
    @Binding var system: Int

    var body: some View {
        Picker(selection: $system, label: Text("System")) {
            Text("°C").tag(0)
            Text("°F").tag(1)
        }
        .pickerStyle(SegmentedPickerStyle())
        .frame(width: 100)
        .padding(.vertical)
    }
}

struct LocationTextField: View {
    @Binding var location: String

    var body: some View {
        TextField("Enter Location", text: $location)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .overlay(
                Button(action: {
                    location = ""
                }) {
                    Image(systemName: "xmark.circle")
                        .foregroundColor(.gray)
                }
                .padding(.horizontal),
                alignment: .trailing
            )
    }
}

struct MagnifyingGlassButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "magnifyingglass.circle.fill")
                .font(.title3)
        }
    }
}

struct CityListButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "list.bullet")
        }
    }
}

struct ErrorAlert: View {
    @Binding var showAlert: Bool
    let appAlert: ForecastListViewModel.AppError

    var body: some View {
        EmptyView() // This view is empty as the alert will be triggered in the parent view
    }
}

struct ForecastList: View {
    var forecasts: [ForecastViewModel]

    var body: some View {
        List(forecasts, id: \.day) { day in
            // Extracted ForecastListItem to a component
            ForecastListItem(day: day)
        }
        .listStyle(PlainListStyle())
    }
}

struct ForecastListItem: View {
    var day: ForecastViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text(day.day)
                .fontWeight(.bold)
            HStack(alignment: .center) {
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
