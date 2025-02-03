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
            CalendarWeekView(date: $viewModel.currentDate)
            VStack {
                Text("Selecionar Horario:")
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical)
                Text(formatTime(viewModel.hourSelected))
                    .font(.largeTitle)
                    .overlay {
                        DatePicker(selection: $viewModel.hourSelected, displayedComponents: .hourAndMinute) {}
                            .labelsHidden()
                            .scaleEffect(2)
                            .contentShape(Rectangle())
                            .opacity(0.08)
                    }
                    .cornerRadius(8)
            }
            .padding(.bottom, 48)
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                ForEach(WorkshopService.allCases, id: \.self) { service in
                    Image(systemName: service.image)
                        .frame(width: 32, height: 32)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                        .foregroundStyle(viewModel.service.contains(service) ? .white : .black)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .fill(viewModel.service.contains(service) ? .black : .white)
                                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                            
                        )
                        .onTapGesture {
                            if viewModel.service.contains(service) {
                                viewModel.service.remove(service)
                            } else {
                                viewModel.service.insert(service)
                            }
                        }
                }
            }
            .padding(.bottom, 32)
            Text("Nota:")
                .font(.title2)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField("", text: $viewModel.text, axis: .vertical)
                .lineLimit(5, reservesSpace: true)
            
                .textFieldStyle(.roundedBorder)
            Spacer()
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
                            .fill(Color(.systemGray))
                            .frame(height: 48)
                            .frame(maxWidth: .infinity)
                    }
                    .safeAreaPadding(32)
            }
            .sheet(isPresented: $viewModel.isBottomSheetOpen) {
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Confirmar agendamento?")
                            .font(.headline)
                            .bold()
                        Spacer()
                        Text(viewModel.currentDate, format: .dateTime.day().month())
                        Text(viewModel.hourSelected, format: .dateTime.hour().minute())
                    }
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
        }
        .alert("Agendamento confirmado", isPresented: $viewModel.alert) {
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
    }
    // Format the time as HH:mm
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
