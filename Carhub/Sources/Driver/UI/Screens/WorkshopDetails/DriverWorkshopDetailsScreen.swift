//
//  DriverWorkshopDetailsScreen.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 29/12/24.
//

import SwiftUI

struct DriverWorkshopDetailsScreen: View {
    @EnvironmentObject private var router: DriverScreenRouter
    @StateObject var viewModel: DriverWorkshopDetailsScreenViewModel
        
    var body: some View {
        view
            .task {
                await viewModel.fetch()
            }
            .navigationTitle(viewModel.workshop?.name ?? "")
            .navigationBarTitleDisplayMode(.large)
            .padding(.horizontal, 24)
    }
    
    @ViewBuilder
    var view: some View {
        switch viewModel.viewState {
        case .loading: ProgressView()
        case .loaded: content
        case .error(let error): ErrorView(error: error)
        }
    }
    
    @ViewBuilder
    var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            headerView
            services
            pickerView
            currentView
            Spacer(minLength: 0)
        }
    }
    
    @ViewBuilder
    var headerView: some View {
        if let workshop = viewModel.workshop {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                        Text("Distância: ").font(.subheadline).bold() + Text(String(format: "%.2f km", workshop.distance)).font(.body)
                    Spacer()
                    AsyncImage(url: .init(string: workshop.photoURL)) { image in
                        image
                            .resizable()
                            .frame(width: 64, height: 64)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 64, height: 64)
                    }
                }
                HStack {
                    VStack {
                        Image(systemName: "hand.thumbsup.fill")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundStyle(Color.green.opacity(0.6))
                        Text("\(workshop.positives)")
                            .font(.caption)
                            .padding(4)
                    }
                    VStack {
                        Image(systemName: "hand.thumbsdown.fill")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundStyle(Color.red.opacity(0.6))
                        Text("\(workshop.negatives)")
                            .font(.caption)
                            .padding(4)
                    }
                    Spacer(minLength: 0)
                    VStack {
                        Image(systemName: "bubble.left.fill")
                            .resizable()
                            .frame(width: 16, height: 16)
                        Text("\(workshop.comments)")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(16)
            }
        }
    }
    
    @ViewBuilder
    var services: some View {
        if let workshop = viewModel.workshop {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                ForEach(workshop.services, id: \.self) { service in
                    Image(systemName: service.image)
                        .frame(width: 32, height: 32)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                        .foregroundStyle(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color(.systemGray4))
                                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                            
                        )
                }
            }
            .padding(8)
        }
    }
    
    @ViewBuilder
    var pickerView: some View {
        Picker("", selection: $viewModel.tab) {
            ForEach(WorkshopDetailsTabEnum.allCases, id: \.self) { tab in
                Text(tab.rawValue).tag(tab)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
    
    @ViewBuilder
    var currentView: some View {
        switch viewModel.tab {
        case .details: details
        case .comments: comments
        case .calendar: calendar
        }
        
    }
    
    @ViewBuilder
    var details: some View {
        if let workshop = viewModel.workshop {
            VStack(alignment: .leading ,spacing: 32) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Detalhes da loja")
                        .font(.headline)
                        .bold()
                    Text(workshop.description)
                        .font(.subheadline)
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Horario de Hoje")
                        .font(.headline)
                        .bold()
                    Text(workshop.todayOpeningHours)
                        .font(.subheadline)
                }
                
                VStack(alignment: .leading) {
                    Text("Endereço")
                        .font(.headline)
                        .bold()
                        .padding(.bottom, 12)
                    Text(workshop.address.street)
                        .font(.subheadline)
                    Text(workshop.address.district)
                        .font(.subheadline)
                    Text("CEP: \(workshop.address.postalCode)")
                        .font(.subheadline)
                }
            }
        }
    }
    
    @ViewBuilder
    var comments: some View {
        WorkshopDetailsCommentsScreen(viewModel: viewModel.commentsViewModel)
    }
    
    @ViewBuilder
    var calendar: some View {
        CalendarView(viewModel: viewModel.calendarViewModel) { date in
            router.navigate(to: viewModel.getRoute())
        }
        .padding(.vertical, 16)
    }
}
