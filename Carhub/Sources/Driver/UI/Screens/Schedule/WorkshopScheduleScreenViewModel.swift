//
//  WorkshopScheduleScreenViewModel.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 11/01/25.
//

import SwiftUI

class WorkshopScheduleScreenViewModel: ObservableObject {
    var id: Int
    var useCase: WorkshopScheduleScreenUseCase = .init()
    
    @Published var currentDate: Date
    @Published var hourSelected: Date = .now
    @Published var text: String = ""
    @Published var service: Set<WorkshopService> = []
    @Published var isBottomSheetOpen: Bool = false
    @Published var sheetHeight: CGFloat = 0
    @Published var isLoading: Bool = false
    @Published var alert: Bool = false
    
    init(currentDate: Date, id: Int) {
        self.currentDate = currentDate
        self.id = id
        print("init \(type(of: self))")
    }
    
    deinit {
        print("de init \(type(of: self))")
    }
    
    @MainActor
    func execute() async -> Bool {
        do {
            isLoading = true
            return try await useCase.execute(with: .init(services: service.filter { _ in true }, date: hourSelected.description, id: id))
        } catch let error {
            print(error.localizedDescription)
            return false
        }
    }
}
