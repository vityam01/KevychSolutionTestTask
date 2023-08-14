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

    
    var body: some View {
        NavigationView {
            List(AppConstants.cities) { city in
                Button(action: {
                    citySelection = city.name
                    isPresented = false
                }) {
                    Text(city.name)
                }
            }
            .navigationTitle(AppConstants.chooseCityText)
            .navigationBarItems(trailing: Button(AppConstants.cancel) {
                isPresented = false
            })
        }
    }
}
