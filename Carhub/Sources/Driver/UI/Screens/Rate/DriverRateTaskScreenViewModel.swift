//
//  DriverRateTaskScreenViewModel.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 29/12/24.
//

import SwiftUI

class DriverRateTaskScreenViewModel: ObservableObject {
    
    let id: Int
    let useCase: RateTaskScreenUseCase = .init()
    
    @Published var state: ScreenState = .loading
    @Published var response: DriverRateResponse? = nil
    @Published var textfieldText: String = ""
    @Published var alert: Bool = false
    
    init(id: Int) {
        self.id = id
        print("init \(type(of: self))")
    }
    
    deinit {
        print("de init \(type(of: self))")
    }
    
    @Published var successMessage: String? = nil
    @Published var errorMessage: String? = nil
    
    @MainActor
    
    func fetch() async {
        do {
            response = try await useCase.fetch(with: id)
            state = .loaded
        } catch let error {
            state = .error(error.localizedDescription)
        }
    }
    
    func execute() async {
        switch await useCase.execute(with: id) {
        case .success:
            successMessage = "Rate successfully"
        case .failure(let error):
            errorMessage = error.localizedDescription
        }
    }
}
