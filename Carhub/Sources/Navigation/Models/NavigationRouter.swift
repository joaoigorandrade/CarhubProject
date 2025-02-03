//
//  Router.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 02/02/25.
//


import SwiftUI

protocol NavigationRouter: ObservableObject {
    associatedtype SelfDestination: NavigationDestination
    associatedtype NavigationTab: NavigationTabBarProtocol
    var state: [NavigationTab: NavigationState<SelfDestination>] { get set }
    var currentTab: NavigationTab? { get set }
    func navigate(to destination: SelfDestination)
    func openSheet(of destination: SelfDestination)
    func pop()
    func backToHome()
    init()
}
