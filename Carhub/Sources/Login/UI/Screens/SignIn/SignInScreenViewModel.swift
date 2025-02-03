//
//  SignInScreenViewModel.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 29/12/24.
//

import SwiftUI

class SignInScreenViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var state: ScreenState = .loaded
    
    let useCase: SignInUseCase = .init()
    
    init () { }
    
    func signIn () async -> Authentication {
//        state = .loading
//        do {
//            let user: User = try await useCase.execute(with: .init(email: email, password: password))
            return .init(isAuthenticated: true, userType: .driver)
//        } catch let error {
//            state = .error(error.localizedDescription)
//            return .init(isAuthenticated: false, userType: nil)
//        }
    }
}
