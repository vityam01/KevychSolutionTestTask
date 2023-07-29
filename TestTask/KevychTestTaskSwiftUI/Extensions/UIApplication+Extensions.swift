//
//  Extensions.swift
//  KevychTestTaskSwiftUI
//
//  Created by Vitya Mandryk on 26.07.2023.
//


import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
