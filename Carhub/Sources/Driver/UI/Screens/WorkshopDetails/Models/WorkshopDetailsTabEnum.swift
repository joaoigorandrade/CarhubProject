//
//  WorkshopDetailsTabEnum.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 03/02/25.
//

import SwiftUI

enum WorkshopDetailsTabEnum: String, Hashable, CaseIterable {
    case details = "Detalhes"
    case comments = "Comentários"
    case calendar = "Agendar"
    
    @ViewBuilder
    var image: some View {
        switch self {
        case .calendar: Image(systemName: "calendar")
        case .comments: Image(systemName: "bubble.left.fill")
        case .details: Image(systemName: "list.bullet")
        }
    }
}
