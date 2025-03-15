//
//  NavigationState.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 02/02/25.
//

import SwiftUI

public class NavigationState<Destination: NavigationDestination>: ObservableObject {
    @Published public var path: [Destination] = .init()
    @Published public var presentingSheet: Destination? = nil
    
    public init(path: [Destination] = [], presentingSheet: Destination? = nil) {
        self.path = path
        self.presentingSheet = presentingSheet
    }
}
