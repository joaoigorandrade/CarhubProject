//
//  DriverHomeScreenViewModel.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 29/12/24.
//

import SwiftUI

class DriverHomeScreenViewModel: ObservableObject {
    
    private let useCase: DriverHomeScreenUseCase = .init()
    private var didLoad: Bool = false
    
    init() {
        print("init \(type(of: self))")
    }
    
    deinit {
        print("de init \(type(of: self))")
    }
    
    var canFetchJobs: Bool = true
    
    @Published var tasks: [WorkshopTask] = []
    @Published var state: ScreenState = .loading
    
    @MainActor
    func fetchJobs(force: Bool? = nil) async {
        if force ?? !didLoad {
            do {
                tasks = try await useCase.execute()
                state = .loaded
                didLoad = true
            } catch let error {
                state = .error(error.localizedDescription)
                didLoad = false
            }
        }
    }
}
