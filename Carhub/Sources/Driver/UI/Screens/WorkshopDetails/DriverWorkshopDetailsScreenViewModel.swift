//
//  DriverWorkshopDetailsScreenViewModel.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 29/12/24.
//

import SwiftUI

class DriverWorkshopDetailsScreenViewModel: ScreenViewModel {
    private let id: Int
    private let useCase: DriverWorkshopDetailsScreenUseCase = .init()
    
    @Published var currentDate: Date = .now
    @Published var tab: WorkshopDetailsTabEnum = .details
    @Published var workshop: WorkshopDetailsModel? = nil
    
    @Published var viewState: ScreenState = .loading
    
    @Published var commentsViewModel: WorkshopDetailsCommentsScreenViewModel
    @Published var calendarViewModel: CalendarViewModel
    
    init(id: Int) {
        self.id = id
        self.commentsViewModel = .init(id: id)
        self.calendarViewModel = .init(currentDate: .now)
        print("init \(type(of: self))")
    }
    
    deinit {
        print("de init \(type(of: self))")
    }
    
    func getRoute(with date: Date) -> DriverScreenDestination {
        .workshopSchedule(id: id, date: date)
    }
    
    @MainActor
    func fetch(force: Bool = false) async {
        switch viewState {
        case .loading, .error: await execute()
        case .loaded: if force { await execute() }
        }
    }
    
    @MainActor
    private func execute() async {
        do {
            workshop = try await useCase.fetch(id: id)
            viewState = .loaded
        } catch let error {
            viewState = .error(error.localizedDescription)
        }
    }
}


