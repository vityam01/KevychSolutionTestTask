//
//  HourlyWeatherViewModel.swift
//  KevychTestTaskSwiftUI
//
//  Created by Vitya Mandryk on 10.08.2023.
//

import Foundation


struct HourlyWeatherViewModel: Identifiable {
    let id = UUID()
    let dateTime: Date
    let temperature: Double
}
