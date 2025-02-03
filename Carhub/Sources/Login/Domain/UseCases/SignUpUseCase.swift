//
//  SignUpUseCase.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 28/12/24.
//

class SignUpUseCase {
    let service: APIClient<LoginRequest> = .init()
    
    init() { }
    
    func execute(with credentials: Credentials) async throws -> Driver {
        do {
            return try await service.sendRequest(.signUp(credentials))
        } catch let error {
            throw error
        }
    }
}
