//
//  NavigationState.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 02/02/25.
//

import SwiftUI

class NavigationState<Destination: NavigationDestination>: ObservableObject {
    @Published var path: [Destination] = .init()
    @Published var presentingSheet: Destination? = nil
}
