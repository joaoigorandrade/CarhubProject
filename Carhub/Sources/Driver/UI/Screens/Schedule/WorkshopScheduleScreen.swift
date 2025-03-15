//
//  WorkshopScheduleScreen.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 11/01/25.
//

import SwiftUI

struct WorkshopScheduleScreen: View {
    @EnvironmentObject private var router: DriverScreenRouter
    @StateObject var viewModel: WorkshopScheduleScreenViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    calendarView
                    hourSelectView
                    workshopServicesView
                    Spacer()
                }
            }
            scheduleButtonView
        }
        .sheet(isPresented: $viewModel.isBottomSheetOpen) {
            scheduleSheetView
        }
        .alert("Agendamento confirmado", isPresented: $viewModel.alert) {
            confirmationAlertView
        }
        .task {
            if viewModel.availableTimes.isEmpty {
                await viewModel.executeAvailableTimes()
            }
        }

    }
    
    @ViewBuilder
    private var calendarView: some View {
        CalendarWeekView(date: $viewModel.currentDate)
    }
    
    @ViewBuilder
    private var hourSelectView: some View {
        if viewModel.availableTimesForDate.isEmpty {
            Text("Não há horários disponíveis para o dia selecionado.")
        } else {
            VStack {
                Text("Selecionar Horario:")
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical)
                LazyVGrid(columns: adaptiveColumn) {
                    ForEach(viewModel.availableTimesForDate, id: \.self) { time in
                        Button {
                            if viewModel.selectedTime[viewModel.date] == time {
                                viewModel.selectedTime[viewModel.date] = nil
                            } else {
                                viewModel.selectedTime[viewModel.date] = time
                            }
                        } label: {
                            Text(time)
                            .padding(8)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                            .foregroundStyle(viewModel.selectedTime[viewModel.date] == time ? .white : .black)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(viewModel.selectedTime[viewModel.date] == time ? .black : .white)
                                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                                
                            )
                        }
                    }
                }
            }
            .padding(.bottom, 48)
        }
    }
    
    private let adaptiveColumn = [
        GridItem(.adaptive(minimum: 130))
    ]
    
    @ViewBuilder
    private var workshopServicesView: some View {
        ForEach(WorkshopServiceCategory.allCases) { category in
            VStack(alignment: .leading) {
                Button {
                    withAnimation {
                        viewModel.categoryIsHide[category]?.toggle()
                    }
                } label: {
                    HStack {
                        Text(category.rawValue)
                            .bold()
                        Image(systemName: "chevron.right")
                            .rotationEffect((viewModel.categoryIsHide[category] ?? false) ? .degrees(90) : .degrees(0))
                        
                    }
                }
                LazyVGrid(columns: adaptiveColumn,alignment: .leading, spacing: 10) {
                    ForEach(WorkshopService.allCases, id: \.self) { service in
                        if viewModel.categoryIsHide[category] ?? false, service.category == category {
                            Button {
                                if viewModel.service.contains(service) {
                                    viewModel.service.remove(service)
                                } else {
                                    viewModel.service.insert(service)
                                }
                                
                            } label: {
                                HStack {
                                    Image(systemName: service.image)
                                        .frame(width: 24, height: 24)
                                    Text(service.rawValue)
                                        .font(.caption)
                                        .bold()
                                }
                                .padding(8)
                                .clipShape(RoundedRectangle(cornerRadius: 4))
                                .foregroundStyle(viewModel.service.contains(service) ? .white : .black)
                                .background(
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(viewModel.service.contains(service) ? .black : .white)
                                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                                    
                                )
                            }
                        }
                    }
                }
            }
        }
        .padding(.bottom, 32)
    }
    
    @ViewBuilder
    private var noteView: some View {
        Text("Nota:")
            .font(.title2)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
        TextField("", text: $viewModel.text, axis: .vertical)
            .lineLimit(5, reservesSpace: true)
            .textFieldStyle(.roundedBorder)
    }
    
    @ViewBuilder
    private var scheduleButtonView: some View {
        Button {
            viewModel.isBottomSheetOpen = true
        } label: {
            Text("Agendar")
                .font(.headline)
                .bold()
                .foregroundColor(Color(.white))
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(height: 48)
                        .frame(maxWidth: .infinity)
                }
                .safeAreaPadding(.bottom, 24)
        }
        .disabled(viewModel.service.isEmpty || viewModel.selectedTime.isEmpty)
    }
    
    @ViewBuilder
    private var scheduleSheetView: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Confirmar agendamento?")
                    .font(.headline)
                    .bold()
                Spacer()
                Text(viewModel.currentDate, format: .dateTime.day().month())
                Text(viewModel.selectedTime[viewModel.date] ?? "")
            }
            noteView
            ForEach(viewModel.service.filter { _ in true }, id: \.self) { service in
                HStack {
                    Image(systemName: service.image)
                    Text(service.rawValue)
                }
            }
            Button {
                Task {
                    if await viewModel.execute() {
                        viewModel.alert = true
                        viewModel.isLoading = false
                    } else {
                        viewModel.isBottomSheetOpen = false
                        viewModel.isLoading = false
                    }
                }
            } label: {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.green.opacity(0.5))
                                .frame(height: 48)
                                .frame(maxWidth: .infinity)
                        }
                } else {
                    Text("Confirmar")
                        .font(.headline)
                        .bold()
                        .foregroundColor(Color(.white))
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.green.opacity(0.5))
                                .frame(height: 48)
                                .frame(maxWidth: .infinity)
                        }
                }
            }
            .padding(.top, 32)
        }
        .padding(32)
        .overlay {
            GeometryReader { geometry in
                Color.clear.preference(key: InnerHeightPreferenceKey.self, value: geometry.size.height)
            }
        }
        .onPreferenceChange(InnerHeightPreferenceKey.self) { newHeight in
            viewModel.sheetHeight = newHeight
        }
        .presentationDetents([.height(viewModel.sheetHeight)])
    }
    
    @ViewBuilder
    private var confirmationAlertView: some View {
        VStack {
            Text("Compareça no horario marcado")
            Button {
                viewModel.alert = false
                router.pop()
            } label: {
                Text("Ok")
            }
        }
    }
    
    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
}

struct InnerHeightPreferenceKey: PreferenceKey {
    static let defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#Preview {
    WorkshopScheduleScreen(viewModel: .init(currentDate: .now, workshop: .init(id: 3, name: "", photoURL: "", distance: 340.0, positives: 30, negatives: 20, comments: 30, description: "", todayOpeningHours: "", services: [], address: .init(street: "", district: "", postalCode: ""))))
}
