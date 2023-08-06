//
//  HourlyForecast.swift
//  KevychTestTaskSwiftUI
//
//  Created by Vitya Mandryk on 06.08.2023.
//

import Foundation


struct HourlyForecast: Codable {
    struct Daily: Codable {
        let dt: Date
        let temp: Double
    }
    let hourly: [Daily]
}
