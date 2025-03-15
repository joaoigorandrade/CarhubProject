//
//  Tab.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 02/02/25.
//

import Navigation
import SwiftUI

enum DriverTab: NavigationTabBarProtocol {
    
    case home
    case search
    case profile
    
    static var initialSelection: DriverTab { .home }
    var id: DriverTab { self }
    
    var title: String {
        switch self {
        case .home: return "Serviços"
        case .search: return "Buscar"
        case .profile: return "Perfil"
        }
    }
    
    var systemImage: String {
        switch self {
        case .home: "house.fill"
        case .search: "magnifyingglass.circle.fill"
        case .profile: "person.circle.fill"
        }
    }
    
    var rootView: some View {
        switch self {
        case .home: DriverHomeScreen()
        case .search: DriverSearchScreen()
        case .profile: DriverProfileScreen()
        }
    }
}
