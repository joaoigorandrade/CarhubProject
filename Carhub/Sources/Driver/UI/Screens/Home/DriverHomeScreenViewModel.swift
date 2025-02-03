//
//  DriverHomeScreenViewModel.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 29/12/24.
//

import SwiftUI

class DriverHomeScreenViewModel: ScreenViewModel {
    
    private let useCase: DriverHomeScreenUseCase = .init()
    
    init() {
        print("init \(type(of: self))")
    }
    
    deinit {
        print("de init \(type(of: self))")
    }
    
    @Published var tasks: [WorkshopTask] = []
    @Published var viewState: ScreenState = .loading
    
    @MainActor
    func fetchJobs(force: Bool = false) async {
        switch viewState {
        case .loading,.error: await execute()
        case .loaded: if force { await execute() }
        }
    }
    
    @MainActor
    private func execute() async {
        do {
            tasks = try await useCase.execute()
            viewState = .loaded
        } catch let error {
            viewState = .error(error.localizedDescription)
        }
    }
}
