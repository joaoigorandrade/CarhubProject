//
//  DriverSearchScreenViewModel.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 29/12/24.
//

import Combine
import SwiftUI

class DriverSearchScreenViewModel: ObservableObject {
    let useCase: DriverSearchScreenUseCase = .init()
    @Published var viewState: ScreenState = .loading
    
    private var cancellables: Set<AnyCancellable> = []
    private var initialSearchTriggered = false
    
    init() {
        print("init \(type(of: self))")
    }
    
    deinit {
        print("de init \(type(of: self))")
    }

    
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
    func search() async {
        do {
            viewState = .loading
            options = try await useCase.execute(with: .init(seachTerm: searchText, orderBy: filterOption))
            viewState = .loaded
        } catch let error {
            viewState = .error(error.localizedDescription)
        }
    }
    
    func triggerInitialSearch() {
        guard !initialSearchTriggered else { return }
        initialSearchTriggered = true
    }
    
    @MainActor
    func performInitialSearch() async {
        if initialSearchTriggered {
            do {
                options = try await useCase.execute(with: .init(seachTerm: "", orderBy: filterOption))
                viewState = .loaded
            } catch let error {
                viewState = .error(error.localizedDescription)
            }
        }
    }
}
