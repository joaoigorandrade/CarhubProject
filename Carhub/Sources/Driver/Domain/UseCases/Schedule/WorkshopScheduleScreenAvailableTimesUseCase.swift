//
//  WorkshopScheduleScreenAvailableTimesUseCase.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 09/02/25.
//

import Foundation

class WorkshopScheduleScreenAvailableTimesUseCase {
    let service: APIClient<DriverApiRequest> = .init()
    
    init() { }
    
    func execute(with model: WorkshopScheduleAvailableTimesRequest) async throws -> [WorkshopScheduleScreenAvailableTimesResponse] {
        return try await service.sendRequest(.getSchedule(model: model))
    }
}

struct WorkshopScheduleScreenAvailableTimesResponse: Decodable {
    let date: String
    let times: [String]
}
