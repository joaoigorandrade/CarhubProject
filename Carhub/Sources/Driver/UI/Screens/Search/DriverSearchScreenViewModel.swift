//
//  DriverSearchScreenViewModel.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 29/12/24.
//

import Combine
import SwiftUI

class DriverSearchScreenViewModel: ObservableObject {
    
    private let useCase: DriverSearchScreenUseCase = .init()
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        print("init \(type(of: self))")
    }
    
    deinit {
        print("de init \(type(of: self))")
    }
    
    @Published var viewState: ScreenState = .loading
    @Published var searchText: String = ""
    @Published var nearMe: Bool = false
    @Published var filterOption: DriverFilterOptions = .distance
    @Published var options: [DriverWorkshopCardModel] = []
    
    var filteredOptions: [DriverWorkshopCardModel] {
        var filtered = options
        
        if !searchText.isEmpty {
            filtered = filtered.filter { model in
                model.name.localizedCaseInsensitiveContains(searchText) ||
                model.services.contains { $0.rawValue.localizedCaseInsensitiveContains(searchText) }
            }
        }
        
        filtered.sort { (a: DriverWorkshopCardModel, b: DriverWorkshopCardModel) -> Bool in
            switch filterOption {
            case .rating:
                return a.positives > b.positives
            case .distance:
                return a.distance < b.distance
            case .higherPrice:
                return a.price > b.price
            case .lowerPrice:
                return a.price < b.price
            }
        }
        
        return filtered
    }
    
    @MainActor
    func search(force: Bool = false) async {
        switch viewState {
        case .loading, .error: await execute()
        default: if force { await execute() }
        }
    }
    
    @MainActor
    private func execute() async {
        do {
            options = try await useCase.execute(with: .init(seachTerm: searchText, orderBy: filterOption))
            viewState = .loaded
        } catch let error {
            viewState = .error(error.localizedDescription)
        }
    }
}
