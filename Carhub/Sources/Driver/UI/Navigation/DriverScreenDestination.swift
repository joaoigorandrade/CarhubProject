//
//  ScreenDestination.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 02/02/25.
//

import SwiftUI

enum DriverScreenDestination: NavigationDestination {
    // MARK: Home
    case home
    case rateTask(id: Int)
    
    // MARK: Search
    case workshopSearch
    case workshopDetails(id: Int)
    case workshopSchedule(id: Int, date: Date)
    
    // MARK: Profile
    case profile
    
    @MainActor
    @ViewBuilder
    var view: some View {
        switch self {
        case .rateTask(let id): DriverRateTaskScreen(viewModel: DriverRateTaskScreenViewModel(id: id))
        case .workshopDetails(let id): DriverWorkshopDetailsScreen(viewModel: DriverWorkshopDetailsScreenViewModel(id: id))
        case .workshopSchedule(let id, let date): WorkshopScheduleScreen(viewModel: WorkshopScheduleScreenViewModel(currentDate: date, id: id))
        case .home: DriverHomeScreen()
        case .workshopSearch: DriverSearchScreen()
        case .profile: EmptyView()
        }
    }
    
    var id: Self { self }
}
