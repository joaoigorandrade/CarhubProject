//
//  CalendarViewModel.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 11/01/25.
//

import Foundation
import SwiftUI

class CalendarViewModel: ObservableObject {
    @Published var currentDate: Date
    
    init(currentDate: Date) {
        self.currentDate = currentDate
        print("init \(type(of: self))")
    }
    
    deinit {
        print("de init \(type(of: self))")
    }
    
    private var calendar: Calendar {
        var calendar = Calendar.current
        calendar.firstWeekday = 1
        return calendar
    }
    
    var currentMonthYear: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: currentDate)
    }
    
    func daysInMonth() -> [CalendarDay] {
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))!
        let range = calendar.range(of: .day, in: .month, for: startOfMonth)!
        
        let firstWeekday = calendar.component(.weekday, from: startOfMonth)
        let prefixDays = Array(repeating: CalendarDay(date: nil, isPlaceholder: true), count: firstWeekday - 1)
        
        let days = range.compactMap { day -> CalendarDay in
            let date = calendar.date(byAdding: .day, value: day - 1, to: startOfMonth)!
            return CalendarDay(date: date, isPlaceholder: false)
        }
        
        return prefixDays + days
    }
    
    func navigateMonth(by value: Int) {
        currentDate = calendar.date(byAdding: .month, value: value, to: currentDate) ?? currentDate
    }
    
    var currentWeekRange: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        guard let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: currentDate)?.start else {
            return ""
        }
        let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek)!
        return "\(formatter.string(from: startOfWeek)) - \(formatter.string(from: endOfWeek))"
    }
    
    func daysInCurrentWeek() -> [CalendarDay] {
        guard let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: currentDate)?.start else {
            return []
        }
        let days = (0..<7).map { offset in
            let date = calendar.date(byAdding: .day, value: offset, to: startOfWeek)!
            return CalendarDay(date: date, isPlaceholder: false)
        }
        return days
    }
    
    func navigateWeek(by value: Int) {
        if let newDate = calendar.date(byAdding: .weekOfYear, value: value, to: currentDate) {
            currentDate = newDate
        }
    }
}
