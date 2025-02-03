//
//  DriverWorkshopDetailsScreenViewModel.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 29/12/24.
//

import SwiftUI

class DriverWorkshopDetailsScreenViewModel: ObservableObject {
    let id: Int
    let useCase: DriverWorkshopDetailsScreenUseCase = .init()
    
    @Published var currentDate: Date = .now
    @Published var viewState: ScreenState = .loading
    @Published var tab: WorkshopDetailsTabEnum = .details
    @Published var workshop: WorkshopDetailsModel? = nil
    
    var comments: [WorkshopDetailsComment] = []
    
    init(id: Int) {
        self.id = id
        print("init \(type(of: self))")
    }
    
    deinit {
        print("de init \(type(of: self))")
    }
    
    @MainActor
    func fetchDWorkShopDetails() async {
        do {
            workshop = try await useCase.fetch(id: id)
            viewState = .loaded
        } catch let error {
            viewState = .error(error.localizedDescription)
        }
    }
}

enum WorkshopDetailsTabEnum: String, Hashable, CaseIterable {
    case details = "Detalhes"
    case comments = "Comentários"
    case calendar = "Agendar"
}

struct WorkshopDetailsComment: Codable, Identifiable, Hashable {
    var id: Int
    var text: String
    var author: String
    var date: String
    var rating: WorkshopRateType
}
