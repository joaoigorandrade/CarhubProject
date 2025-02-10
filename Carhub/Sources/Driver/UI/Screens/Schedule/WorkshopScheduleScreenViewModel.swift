//
//  WorkshopScheduleScreenViewModel.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 11/01/25.
//

import SwiftUI

class WorkshopScheduleScreenViewModel: ObservableObject {
    var workshop: WorkshopDetailsModel
    var useCase: WorkshopScheduleScreenUseCase = .init()
    var availableTimesUseCase: WorkshopScheduleScreenAvailableTimesUseCase = .init()
    
    var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: currentDate)
    }
    
    var availableTimesForDate: [String] {
        return availableTimes.first(where: { response in
            return response.date == date
        })?.times ?? []
    }
    
    @Published var currentDate: Date {
        didSet {
            selectedTime = [:]
        }
    }
    @Published var hourSelected: Date = .now
    @Published var text: String = ""
    @Published var service: Set<WorkshopService> = []
    @Published var categoryIsHide: [WorkshopServiceCategory: Bool] = WorkshopServiceCategory.allCases.reduce(into: [WorkshopServiceCategory: Bool]()) { $0[$1] = false }
    @Published var isBottomSheetOpen: Bool = false
    @Published var sheetHeight: CGFloat = 0
    @Published var isLoading: Bool = false
    @Published var alert: Bool = false
    @Published var availableTimes: [WorkshopScheduleScreenAvailableTimesResponse] = []
    @Published var selectedTime: [String: String] = [:]
    
    init(currentDate: Date, workshop: WorkshopDetailsModel) {
        self.currentDate = currentDate
        self.workshop = workshop
        print("init \(type(of: self))")
    }
    
    deinit {
        print("de init \(type(of: self))")
    }
    
    @MainActor
    func execute() async -> Bool {
        do {
            isLoading = true
            return try await useCase.execute(with: .init(services: service.filter { _ in true },
                                                         date: hourSelected.description,
                                                         id: workshop.id))
        } catch let error {
            print(error.localizedDescription)
            return false
        }
    }
    
    @MainActor
    func executeAvailableTimes() async {
        do {
            availableTimes = try await availableTimesUseCase.execute(with: .init(id: workshop.id, date: currentDate))
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
