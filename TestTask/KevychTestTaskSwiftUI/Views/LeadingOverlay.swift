//
//  LeadingOverlay.swift
//  KevychTestTaskSwiftUI
//
//  Created by Vitya Mandryk on 31.07.2023.
//

import SwiftUI

struct LoadingOverlay: View {
    var body: some View {
        ZStack {
            Color(.white)
                .opacity(0.3)
                .ignoresSafeArea()
            ProgressView("Fetching Weather")
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.systemBackground))
                )
                .shadow(radius: 10)
        }
    }
}
