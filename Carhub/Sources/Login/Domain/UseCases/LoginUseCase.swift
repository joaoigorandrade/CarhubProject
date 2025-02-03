//
//  Untitled.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 28/12/24.
//

class SignInUseCase {
    let service: APIClient<LoginRequest> = .init()
    
    init() { }
    
    func execute(with credentials: SignInCredentials) async throws -> User {
        return try await service.sendRequest(.signIn(credentials))
    }
}
