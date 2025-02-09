import SwiftUI

struct CalendarView: View {
    @ObservedObject private var viewModel: CalendarViewModel
    @Namespace private var animation
    
    private let onSelectDate: (Date) -> Void
    
    init(viewModel: CalendarViewModel, onSelectDate: @escaping (Date) -> Void) {
        self.viewModel = viewModel
        self.onSelectDate = onSelectDate
    }
    
    
    var body: some View {
        VStack(spacing: 0) {
            yearHeader
            Divider()
                .padding(.vertical)
            daysOfWeek
            days
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(UIColor.secondarySystemBackground))
                .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
        )
        .transition(.opacity)
        .animation(.easeInOut, value: viewModel.currentDate)
    }
    
    @ViewBuilder
    var yearHeader: some View {
        HStack {
            Button(action: { viewModel.navigateMonth(by: -1) }) {
                Image(systemName: "chevron.left")
                    .padding()
            }
            
            Spacer()
            
            Text(viewModel.currentMonthYear)
                .font(.title2)
                .fontWeight(.bold)
            
            Spacer()
            
            Button(action: { viewModel.navigateMonth(by: 1) }) {
                Image(systemName: "chevron.right")
                    .padding()
            }
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
            ForEach(viewModel.daysInMonth()) { calendarDay in
                if let date = calendarDay.date {
                    let isToday = calendarDay.isToday
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
                        .foregroundColor(isToday ? .white : .primary)
                        .scaleEffect(isToday ? 1.2 : 1.0)
                        .onTapGesture {
                            onSelectDate(date)
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
