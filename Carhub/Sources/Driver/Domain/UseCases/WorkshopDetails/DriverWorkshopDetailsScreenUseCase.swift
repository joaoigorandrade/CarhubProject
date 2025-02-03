//
//  DriverWorkshopDetailsScreenUseCase.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 29/12/24.
//

class DriverWorkshopDetailsScreenUseCase {
    let service: APIClient<DriverApiRequest> = .init()
    
    func fetch(id: Int) async throws -> WorkshopDetailsModel {
        return try await service.sendRequest(.getWorkshop(id: id))
    }
}
