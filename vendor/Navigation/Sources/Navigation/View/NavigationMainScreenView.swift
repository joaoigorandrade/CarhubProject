//
//  MainView.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 02/02/25.
//

import SwiftUI

public struct NavigationMainScreenView<Router: NavigationRouter, Tab: NavigationTabBarProtocol, Content: View>: View where Router.NavigationTab == Tab {
    @ObservedObject private var router: Router
    @ObservedObject private var navigationState: NavigationState<Router.SelfDestination>
    
    @State private var sheetHeight: CGFloat = .zero
    private let content: Content
    private let tab: Tab
    
    public init(router: Router, tab: Tab, @ViewBuilder content: @escaping () -> Content) {
        self.router = router
        self.tab = tab
        self.navigationState = router.state[tab] ?? .init()
        self.content = content()
    }
    
    private var pathBinding: Binding<[Router.SelfDestination]> {
        Binding(
            get: { router.state[tab]?.path ?? [] },
            set: { router.state[tab]?.path = $0 }
        )
    }
    
    private var presentingSheetBinding: Binding<Router.SelfDestination?> {
        Binding(
            get: { router.state[tab]?.presentingSheet },
            set: { router.state[tab]?.presentingSheet = $0 }
        )
    }
    
    public var body: some View {
        NavigationStack(path: pathBinding) {
            content
                .navigationDestination(for: Router.SelfDestination.self) { $0.view }
        }
        .sheet(item: presentingSheetBinding) { destination in
            destination.view
                .overlay {
                    GeometryReader { geometry in
                        Color.clear.preference(key: NavigationInnerHeightPreferenceKey.self, value: geometry.size.height)
                    }
                }
                .presentationDetents([.height(sheetHeight)])
                .environmentObject(router)
        }
    }
}
