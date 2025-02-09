//
//  CalendarViewModel.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 11/01/25.
//

import Foundation
import SwiftUI

// MARK: - CalendarViewModel

class CalendarViewModel: ObservableObject {
    @Published var currentDate: Date {
        didSet {
            updateDaysForMonth()
        }
    }
    @Published var days: [CalendarDay] = []
    
    init(currentDate: Date) {
        self.currentDate = currentDate
        updateDaysForMonth()
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
        DateFormatter.monthYear.string(from: currentDate)
    }
    
    private func updateDaysForMonth() {

        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))!
        let range = calendar.range(of: .day, in: .month, for: startOfMonth)!
        
        let firstWeekday = calendar.component(.weekday, from: startOfMonth)
        let prefixDays = (0..<(firstWeekday - 1)).map { index in
            CalendarDay(date: nil, isPlaceholder: true, stableId: "placeholder-\(index)")
        }
        
        let monthDays = range.map { day -> CalendarDay in
            let date = calendar.date(byAdding: .day, value: day - 1, to: startOfMonth)!
            return CalendarDay(date: date, isPlaceholder: false)
        }
        
        DispatchQueue.main.async {
            self.days = prefixDays + monthDays
        }
    }
    
    func navigateMonth(by value: Int) {
        if let newDate = calendar.date(byAdding: .month, value: value, to: currentDate) {
            currentDate = newDate
        }
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
        return (0..<7).map { offset in
            let date = calendar.date(byAdding: .day, value: offset, to: startOfWeek)!
            return CalendarDay(date: date, isPlaceholder: false)
        }
    }
    
    func navigateWeek(by value: Int) {
        if let newDate = calendar.date(byAdding: .weekOfYear, value: value, to: currentDate) {
            currentDate = newDate
        }
    }
}
