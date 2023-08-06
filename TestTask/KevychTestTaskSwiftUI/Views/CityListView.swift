//
//  CityListView.swift
//  KevychTestTaskSwiftUI
//
//  Created by Vitya Mandryk on 06.08.2023.
//

import SwiftUI

// MARK: - CityList

struct CityList: View {
    @Binding var citySelection: String
    @Binding var isPresented: Bool

    // Cities array...
    let cities: [City] = [
        City(name: "Бердянськ", latitude: 46.7563, longitude: 36.7860),
        City(name: "Біла Церква", latitude: 49.8000, longitude: 30.1167),
        City(name: "Бровари", latitude: 50.5167, longitude: 30.8167),
        City(name: "Вінниця", latitude: 49.2331, longitude: 28.4682),
        City(name: "Дніпро", latitude: 48.4647, longitude: 35.0462),
        City(name: "Донецьк", latitude: 48.0159, longitude: 37.8029),
        City(name: "Житомир", latitude: 50.2547, longitude: 28.6587),
        City(name: "Запоріжжя", latitude: 47.8388, longitude: 35.1396),
        City(name: "Івано-Франківськ", latitude: 48.9226, longitude: 24.7111),
        City(name: "Кам'янське", latitude: 48.5458, longitude: 34.5969),
        City(name: "Київ", latitude: 50.4501, longitude: 30.5234),
        City(name: "Кривий Ріг", latitude: 47.9101, longitude: 33.3913),
        City(name: "Луцьк", latitude: 50.7599, longitude: 25.3425),
        City(name: "Львів", latitude: 49.8397, longitude: 24.0297),
        City(name: "Макіївка", latitude: 48.0473, longitude: 37.9256),
        City(name: "Маріуполь", latitude: 47.0968, longitude: 37.5564),
        City(name: "Мелітополь", latitude: 46.8501, longitude: 35.3653),
        City(name: "Миколаїв", latitude: 46.9750, longitude: 31.9946),
        City(name: "Одеса", latitude: 46.4825, longitude: 30.7233),
        City(name: "Полтава", latitude: 49.5883, longitude: 34.5514),
        City(name: "Рівне", latitude: 50.6199, longitude: 26.2516),
        City(name: "Севастополь", latitude: 44.6167, longitude: 33.5254),
        City(name: "Сімферополь", latitude: 44.9521, longitude: 34.1024),
        City(name: "Суми", latitude: 50.9077, longitude: 34.7981),
        City(name: "Тернопіль", latitude: 49.5535, longitude: 25.5948),
        City(name: "Ужгород", latitude: 48.6208, longitude: 22.2879),
        City(name: "Харків", latitude: 49.9935, longitude: 36.2304),
        City(name: "Херсон", latitude: 46.6354, longitude: 32.6169),
        City(name: "Хмельницький", latitude: 49.4229, longitude: 26.9870),
        City(name: "Черкаси", latitude: 49.4444, longitude: 32.0599),
        City(name: "Чернівці", latitude: 48.2921, longitude: 25.9358),
        City(name: "Чернігів", latitude: 51.4982, longitude: 31.2895),
        City(name: "Чернівці", latitude: 48.2921, longitude: 25.9358),
        City(name: "Шостка", latitude: 51.8625, longitude: 33.4769)
    ]
    
    var body: some View {
        NavigationView {
            List(cities) { city in
                Button(action: {
                    citySelection = city.name
                    isPresented = false
                }) {
                    Text(city.name)
                }
            }
            .navigationTitle("Choose a City")
            .navigationBarItems(trailing: Button("Cancel") {
                isPresented = false
            })
        }
    }
}
