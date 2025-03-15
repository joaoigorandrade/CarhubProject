//
//  ScreenRouter.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 02/02/25.
//

import Navigation
import SwiftUI

class DriverScreenRouter: NavigationRouter {
    
    @Published var state: [DriverTab: NavigationState<DriverScreenDestination>] = [:]
    var currentTab: DriverTab?
    
    required init() {
        for tab in DriverTab.allCases {
            state[tab] = NavigationState()
        }
    }
    
    func navigate(to destination: DriverScreenDestination) {
        guard let currentTab else { return }
        state[currentTab]?.path.append(destination)
    }
    
    func openSheet(of destination: DriverScreenDestination) {
        guard let currentTab else { return }
        state[currentTab]?.presentingSheet = destination
    }
    
    func pop() {
        guard let currentTab else { return }
        _ = state[currentTab]?.path.popLast()
    }
    
    func backToHome() {
        guard let currentTab else { return }
        state[currentTab]?.path.removeAll()
    }
}
