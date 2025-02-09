//
//  LocationManager.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 08/02/25.
//

import CoreLocation
import Foundation
import UIKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    
    @Published var userLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        DispatchQueue.main.async {
            self.userLocation = location.coordinate
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied || status == .restricted {
            print("Location access denied")
        }
    }
    
    func openMapsForDirections(destination: CLLocationCoordinate2D) {
        guard let userLocation else { return }
        let url = URL(string: "maps://?saddr=\(userLocation.latitude),\(userLocation.longitude)&daddr=\(destination.latitude),\(destination.longitude)&dirflg=d")!
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
