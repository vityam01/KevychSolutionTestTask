//
//  LocationManager.swift
//  KevychTestTaskSwiftUI
//
//  Created by Vitya Mandryk on 30.07.2023.
//

import Foundation
import SwiftUI
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var userLatitude: Double?
    @Published var userLongitude: Double?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            userLatitude = location.coordinate.latitude
            userLongitude = location.coordinate.longitude
            locationManager.stopUpdatingLocation()
        }
    }
}

struct LocationManagerWrapper: UIViewControllerRepresentable {
    class Coordinator: NSObject, CLLocationManagerDelegate {
        var parent: LocationManagerWrapper
        
        init(_ parent: LocationManagerWrapper) {
            self.parent = parent
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.last {
                parent.userLatitude = location.coordinate.latitude
                parent.userLongitude = location.coordinate.longitude
                manager.stopUpdatingLocation()
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Location Manager Error: \(error.localizedDescription)")
        }
    }
    
    @Binding var userLatitude: Double
    @Binding var userLongitude: Double
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        viewController.view.backgroundColor = UIColor.clear
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        let locationManager = CLLocationManager()
        locationManager.delegate = context.coordinator
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}
