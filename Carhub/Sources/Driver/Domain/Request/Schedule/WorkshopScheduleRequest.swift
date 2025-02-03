//
//  WorkshopScheduleRequest.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 12/01/25.
//

struct WorkshopScheduleRequest: Codable {
    let services: [WorkshopService]
    let date: String
    let id: Int
}
