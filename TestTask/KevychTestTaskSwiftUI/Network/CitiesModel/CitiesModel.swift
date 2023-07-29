//
//  CitiesModel.swift
//  KevychTestTaskSwiftUI
//
//  Created by Vitya Mandryk on 29.07.2023.
//

import Foundation


struct City: Identifiable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
}

let citiesUkraine: [City] = [
    City(name: "Київ", latitude: 50.4501, longitude: 30.5234),
    City(name: "Львів", latitude: 49.8397, longitude: 24.0297),
    City(name: "Одеса", latitude: 46.4825, longitude: 30.7233),
    City(name: "Харків", latitude: 49.9935, longitude: 36.2304),
    City(name: "Дніпро", latitude: 48.4647, longitude: 35.0462),
    City(name: "Запоріжжя", latitude: 47.8388, longitude: 35.1396),
    City(name: "Вінниця", latitude: 49.2331, longitude: 28.4682),
    City(name: "Херсон", latitude: 46.6354, longitude: 32.6169),
    City(name: "Черкаси", latitude: 49.4444, longitude: 32.0599),
    City(name: "Житомир", latitude: 50.2547, longitude: 28.6587),
    City(name: "Полтава", latitude: 49.5937, longitude: 34.5407),
    City(name: "Суми", latitude: 50.9077, longitude: 34.7981),
    City(name: "Івано-Франківськ", latitude: 48.9226, longitude: 24.7111),
    City(name: "Тернопіль", latitude: 49.5535, longitude: 25.5948),
    City(name: "Хмельницький", latitude: 49.4221, longitude: 26.9965),
    City(name: "Чернівці", latitude: 48.2921, longitude: 25.9352),
    City(name: "Рівне", latitude: 50.6199, longitude: 26.2516),
    City(name: "Луцьк", latitude: 50.7472, longitude: 25.3254),
    City(name: "Ужгород", latitude: 48.6208, longitude: 22.2879),
    City(name: "Маріуполь", latitude: 47.1013, longitude: 37.5185)
]
