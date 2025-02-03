//
//  AppTabBar.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 28/12/24.
//

import SwiftUI

protocol NavigationTabBarProtocol: Hashable, CaseIterable, Identifiable {
    
    associatedtype Body: View
    
    static var initialSelection: Self { get }
    static var allCases: [Self] { get }
    
    var title: String { get }
    var systemImage: String { get }
    var id: Self { get }
    
    @ViewBuilder
    var rootView: Body { get }
}
