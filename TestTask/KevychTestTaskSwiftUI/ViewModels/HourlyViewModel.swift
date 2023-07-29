//
//  HourlyViewModel.swift
//  KevychTestTaskSwiftUI
//
//  Created by Vitya Mandryk on 29.07.2023.
//

import Foundation

class HourlyViewModel: Identifiable, Hashable {
    
    static func == (lhs: HourlyViewModel, rhs: HourlyViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id = UUID()
    let time: String
    let temperature: Double
    
    init(daily: Daily, weather: Weather) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        self.time = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(daily.dt)))
        self.temperature = daily.temp.day
    }
    
}
