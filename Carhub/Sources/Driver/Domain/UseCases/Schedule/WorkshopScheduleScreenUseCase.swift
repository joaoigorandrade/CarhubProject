//
//  WorkshopScheduleScreenUseCase.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 12/01/25.
//

class WorkshopScheduleScreenUseCase {
    let service: APIClient<DriverApiRequest> = .init()

    init() { }
    
    func execute(with model: WorkshopScheduleRequest) async throws -> Bool {
        return try await service.sendRequest(.postSchedule(model: model))
    }
}
