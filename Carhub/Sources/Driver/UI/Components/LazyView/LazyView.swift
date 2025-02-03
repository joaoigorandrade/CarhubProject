//
//  LazyView.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 12/01/25.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let content: () -> Content

    var body: some View {
        content()
    }
}
