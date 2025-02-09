//
//  DateFormatter.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 09/02/25.
//

import Foundation

extension DateFormatter {
    static let monthYear: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
}
