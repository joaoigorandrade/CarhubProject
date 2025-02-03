//
//  RateTaskScreenUseCase.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 29/12/24.
//

class RateTaskScreenUseCase {
    let service: APIClient<DriverApiRequest> = .init()
    
    func fetch(with id: Int) async throws -> DriverRateResponse {
        return try await service.sendRequest(.getRateScreen(id: id))
    }
    
    func execute(with id: Int) async -> Result<String, APIError> {
        do {
            let response: String = try await service.sendRequest(.postPositiveRate(id: id))
            return .success(response)
        } catch let error {
            return .failure(.invalidRequest(error.localizedDescription))
        }
    }
}
