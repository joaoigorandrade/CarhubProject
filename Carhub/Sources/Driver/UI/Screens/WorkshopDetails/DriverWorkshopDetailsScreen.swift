//
//  DriverWorkshopDetailsScreen.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 29/12/24.
//

import SwiftUI

struct DriverWorkshopDetailsScreen: View {
    @EnvironmentObject private var router: DriverScreenRouter
    @EnvironmentObject private var locationManager: LocationManager
    
    @StateObject var viewModel: DriverWorkshopDetailsScreenViewModel
    
    var body: some View {
        view
            .task {
                await viewModel.fetch()
            }
            .ignoresSafeArea(.all, edges: .top)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            router.pop()
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                    }
                }
            }
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
        ScrollView {
            ZStack {
                VStack {
                    headerView
                    Spacer()
                }
                VStack(alignment: .leading, spacing: 0) {
                    services
                    rating
                    pickerView
                    currentView
                }.offset(y: 250)
            }
        }
    }
    
    @ViewBuilder
    var headerView: some View {
        if let workshop = viewModel.workshop {
            StretchyImage(imageURL: .init(string: workshop.photoURL))
                .frame(height: 300)
                .clipped()
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
    var rating: some View {
        if let workshop = viewModel.workshop {
            HStack {
                Text("😀")
                LinearProgressView(model: .init(firstValue: workshop.positives,
                                                secondValue: workshop.negatives,
                                                firstColor: .green,
                                                secondColor: .red),
                                   shape: .capsule)
                .frame(height: 8)
                Text("😡")
            }
            .padding(16)
        }
    }
    
    @ViewBuilder
    var workshopTitle: some View {
        Text("\(viewModel.workshop?.name ?? "")")
            .font(.title)
            .foregroundColor(.black)
            .bold()
    }
    
    @ViewBuilder
    var pickerView: some View {
        Picker("", selection: $viewModel.tab) {
            ForEach(WorkshopDetailsTabEnum.allCases, id: \.self) { tab in
                tab.image
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
    
    @ViewBuilder
    var currentView: some View {
        Group {
            switch viewModel.tab {
            case .details: details
            case .comments: comments
            case .calendar: calendar
            }
        }.padding(24)
    }
    
    @ViewBuilder
    var details: some View {
        if let workshop = viewModel.workshop {
            VStack(alignment: .leading ,spacing: 32) {
                workshopTitle
                VStack(alignment: .leading, spacing: 12) {
                    Text("Detalhes da loja:")
                        .font(.headline)
                        .bold()
                    Text(workshop.description)
                        .font(.subheadline)
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Horario de Hoje:")
                        .font(.headline)
                        .bold()
                    Text(workshop.todayOpeningHours)
                        .font(.subheadline)
                }
                
                VStack(alignment: .leading) {
                    Text("Endereço:")
                        .font(.headline)
                        .bold()
                        .padding(.bottom, 12)
                    HStack {
                        VStack(alignment: .leading) {
                            Text(workshop.address.street)
                                .font(.subheadline)
                            Text(workshop.address.district)
                                .font(.subheadline)
                            Text("CEP: \(workshop.address.postalCode)")
                                .font(.subheadline)
                        }
                        Spacer(minLength: 24)
                        
                        Button {
                            locationManager.openMapsForDirections(destination: .init(latitude: .zero, longitude: .zero))
                        } label: {
                            Image(systemName: "map.fill")
                                .tint(Color.primary)
                                .padding(24)
                        }
                    }
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
            router.navigate(to: viewModel.getRoute(with: date))
        }
        .padding(.vertical, 16)
    }
}

#Preview {
    DriverWorkshopDetailsScreen(viewModel: .init(id: 2))
}
