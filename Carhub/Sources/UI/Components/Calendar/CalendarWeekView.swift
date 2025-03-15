//
//  WeekCalendarView.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 11/01/25.
//


import SwiftUI

struct CalendarWeekView: View {
    @Binding private var date: Date
    @StateObject private var viewModel: CalendarViewModel
    @Namespace private var animation
    
    init(date: Binding<Date>) {
        self._viewModel = .init(wrappedValue: .init(currentDate: date.wrappedValue))
        self._date = date
    }
    
    var body: some View {
        VStack {
            daysOfWeek
            days
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(UIColor.secondarySystemBackground))
                .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
        )
        .onChange(of: viewModel.currentDate) { oldValue, newValue in
            date = newValue
        }
    }
    
    @ViewBuilder
    var daysOfWeek: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
            ForEach(CalendarDayOfWeek.allCases, id: \.self) { day in
                Text(day.firstLetter)
                    .font(.body)
                    .fontWeight(.bold)
                    .frame(width: 36, height: 36)
            }
        }
    }
    
    @ViewBuilder
    var days: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
            ForEach(viewModel.daysInCurrentWeek(), id: \.id) { calendarDay in
                if let date = calendarDay.date {
                    
                    let isToday = Calendar.current.isDate(calendarDay.date ?? .now,
                                                          equalTo: viewModel.currentDate, toGranularity: .day)
                    let isPastDay = Calendar.current.compare(date, to: Date(), toGranularity: .day) == .orderedAscending
                    
                    Text("\(Calendar.current.component(.day, from: date))")
                        .font(.body)
                        .fontWeight(isToday ? .bold : .regular)
                        .frame(width: 36, height: 36)
                        .background(
                            ZStack {
                                if isToday {
                                    Circle()
                                        .fill(Color.blue)
                                        .matchedGeometryEffect(id: "today", in: animation)
                                }
                            }
                        )
                        .foregroundColor(
                            isToday ? .white :
                            isPastDay ? Color.gray : Color.primary
                        )
                        .scaleEffect(isToday ? 1.2 : 1.0)
                        .onTapGesture {
                            if !isPastDay {
                                viewModel.currentDate = date
                            }
                        }
                        .animation(.easeInOut, value: isToday)
                } else {
                    Text("")
                        .frame(width: 36, height: 36)
                }
            }
        }
    }
    
}
