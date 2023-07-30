//
//  SearchBar.swift
//  KevychTestTaskSwiftUI
//
//  Created by Vitya Mandryk on 31.07.2023.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String

    var body: some View {
        HStack {
            TextField("Search", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            Button(action: {
                searchText = ""
            }) {
                Image(systemName: "xmark.circle.fill")
                    .padding(.horizontal)
            }
            .opacity(searchText.isEmpty ? 0 : 1)
        }
    }
}
