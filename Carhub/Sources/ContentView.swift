//
//  ContentView.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 28/12/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var router = DriverScreenRouter()
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        NavigationTabScreenView<DriverTab, DriverScreenRouter>(router: router,
                                                               location: locationManager)
    }
}

#Preview {
    ContentView()
}
