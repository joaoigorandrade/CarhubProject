//
//  CalendarDay.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 11/01/25.
//

import Foundation

struct CalendarDay: Identifiable {
    var id: String { date?.description ?? UUID().uuidString }
    let date: Date?
    let isPlaceholder: Bool
    
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
