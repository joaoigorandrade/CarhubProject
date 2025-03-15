//
//  TabScreenView.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 02/02/25.
//

import SwiftUI

public struct NavigationTabScreenView<Tab: NavigationTabBarProtocol, Router: NavigationRouter>: View where Router.NavigationTab == Tab {
    @State private var tabSelected: Tab = Tab.initialSelection
    @ObservedObject private var router: Router
    
    public init(router: Router) {
        self.router = router
        self.router.currentTab = Tab.initialSelection
    }
    
    public var body: some View {
        TabView(selection: $tabSelected) {
            ForEach(Tab.allCases) { tab in
                NavigationMainScreenView(router: router, tab: tab) {
                    tab.rootView.navigationTitle(tab.title)
                }
                .tabItem {
                    Label(tab.title, systemImage: tab.systemImage)
                }
                .tag(tab)
            }
        }
        .onChange(of: tabSelected) { oldValue, newTab in
            router.currentTab = newTab
        }
        .environmentObject(router)
    }
}
