//
//  WorkShopTask.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 29/12/24.
//

import SwiftUI

struct WorkshopTask: Identifiable, Codable {
    let id: Int
    let workShopId: Int
    let workShopPhoto: String
    let workShopName: String
    let name: WorkshopService
    let status: WorkshopTaskStatus
    let forecast: String
}

enum WorkshopTaskStatus: String, Codable {
    case pending
    case done
    case error
    
    var color: Color {
        switch self {
        case .pending: return .blue
        case .done: return .green
        case .error: return .red
        }
    }
}
