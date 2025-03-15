//
//  NavigationInnerHeightPreferenceKey.swift
//  Navigation
//
//  Created by Joao Igor de Andrade Oliveira on 15/03/25.
//

import Foundation
import SwiftUI

package struct NavigationInnerHeightPreferenceKey: PreferenceKey {
    package static let defaultValue: CGFloat = .zero
    package static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) { value = nextValue() }
}
