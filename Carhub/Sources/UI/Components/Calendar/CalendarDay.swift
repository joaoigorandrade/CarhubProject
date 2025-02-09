//
//  CalendarDay.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 11/01/25.
//

import Foundation

struct CalendarDay: Identifiable {
    let date: Date?
    let isPlaceholder: Bool
    let stableId: String

    var id: String { stableId }

    init(date: Date?, isPlaceholder: Bool, stableId: String? = nil) {
        self.date = date
        self.isPlaceholder = isPlaceholder
        if let id = stableId {
            self.stableId = id
        } else if let date = date {
            self.stableId = date.description
        } else {
            self.stableId = "placeholder-\(UUID().uuidString)"
        }
    }
    
    var isToday: Bool {
        guard let date = date else { return false }
        return Calendar.current.isDateInToday(date)
    }
}

enum CalendarDayOfWeek: String, CaseIterable {
    case sunday = "Domingo"
    case monday = "Segunda-feira"
    case tuesday = "Terça-feira"
    case wednesday = "Quarta-feira"
    case thursday = "Quinta-feira"
    case friday = "Sexta-feira"
    case saturday = "Sábado"
    
    var firstLetter: String {
        self.rawValue.first?.uppercased() ?? ""
    }
}
