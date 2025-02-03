//
//  DriverSearchScreenUseCase.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 28/12/24.
//

class DriverSearchScreenUseCase {
    let service: APIClient<DriverApiRequest> = .init()

    init() { }
    
    func execute(with model: DriverSearchScreenRequest) async throws -> [DriverWorkshopCardModel] {
        return try await service.sendRequest(.postSearchOptions(model: model))
    }
}
