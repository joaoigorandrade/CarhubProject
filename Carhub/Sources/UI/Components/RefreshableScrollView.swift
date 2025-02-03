//
//  RefreshableScrollView.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 02/02/25.
//

import SwiftUI

struct ViewOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct RefreshableScrollView<Content: View>: View {
    @State private var isCurrentlyRefreshing = false
    @State private var isScrolled: Bool = false
    private let amountToPullBeforeRefreshing: CGFloat = -360

    private var content: () -> Content
    private var onRefresh: () async -> Void
    
    init(content: @escaping () -> Content, onRefresh: @escaping () async -> Void) {
        self.content = content
        self.onRefresh = onRefresh
    }
    
    var body: some View {
        ScrollView {
            if isCurrentlyRefreshing {
                ProgressView()
                    .padding(56)
            }
            
            LazyVGrid(columns: [GridItem(.flexible())]) {
                content()
            }
            .overlay {
                GeometryReader { geo in
                    let offset = -geo.frame(in: .global).origin.y
                    
                    Color.clear
                        .preference(key: ViewOffsetKey.self, value: offset)
                }
            }
        }

        .onPreferenceChange(ViewOffsetKey.self) { scrollPosition in
            if scrollPosition < amountToPullBeforeRefreshing {
                if !isScrolled {
                    withAnimation {
                        isScrolled = true
                        isCurrentlyRefreshing = true
                    }
                    
                    Task {
                        await onRefresh()
                        await MainActor.run {
                            withAnimation {
                                isCurrentlyRefreshing = false
                            }
                        }
                    }
                }
            } else if isScrolled {
                withAnimation {
                    isScrolled = false
                }
            }
        }
    }
}
