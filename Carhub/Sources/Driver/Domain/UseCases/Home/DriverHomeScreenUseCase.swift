//
//  DriverHomeScreenUseCase.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 29/12/24.
//

class DriverHomeScreenUseCase {
    let service: APIClient<DriverApiRequest> = .init()
    
    func execute() async throws -> [WorkshopTask] {
        return try await service.sendRequest(.getHomePage)
    }
}
