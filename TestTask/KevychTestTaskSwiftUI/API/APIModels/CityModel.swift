//
//  CityModel.swift
//  KevychTestTaskSwiftUI
//
//  Created by Vitya Mandryk on 07.08.2023.
//

import Foundation

struct City: Identifiable {
    let id: UUID = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
}
