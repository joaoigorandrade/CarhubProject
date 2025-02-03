//
//  NavigationDestination.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 02/02/25.
//

import Foundation
import SwiftUI

protocol NavigationDestination: Hashable, Identifiable {
    associatedtype Content: View
    var view: Content { get }
    var id: Self { get }
}
