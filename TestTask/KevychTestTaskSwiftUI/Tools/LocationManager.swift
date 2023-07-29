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
