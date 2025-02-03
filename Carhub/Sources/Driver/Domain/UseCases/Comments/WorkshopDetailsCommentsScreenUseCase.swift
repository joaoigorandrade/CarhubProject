//
//  WorkshopDetailsCommentsScreenUseCase.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 12/01/25.
//

class WorkshopDetailsCommentsScreenUseCase {
    let service: APIClient<DriverApiRequest> = .init()

    func fetchComments(id: Int) async throws -> [WorkshopDetailsComment] {
        return try await service.sendRequest(.getWorkshopComments(id: id))
    }
}
