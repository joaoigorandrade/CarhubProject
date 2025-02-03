//
//  WorkshopRate.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 29/12/24.
//

import SwiftUI

struct WorkshopRate: Codable, Identifiable {
    let id: Int
    let type: WorkshopRateType
    let comment: String?
}

enum WorkshopRateType: String, Codable {
    case positive
    case negative
    
    var image: String {
        switch self {
        case .positive: "hand.thumbsup"
        case .negative: "hand.thumbsdown"
        }
    }
    
    var color: Color {
        switch self {
        case .positive: .green.opacity(0.4)
        case .negative: .red.opacity(0.4)
        }
    }
}
