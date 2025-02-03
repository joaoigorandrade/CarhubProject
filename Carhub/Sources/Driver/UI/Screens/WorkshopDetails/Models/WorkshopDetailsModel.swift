//
//  WorkshopDetailsModel.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 12/01/25.
//

struct WorkshopDetailsModel: Codable {
    var id: Int
    var name: String
    var photoURL: String
    var distance: Double
    var positives: Int
    var negatives: Int
    var comments: Int
    var description: String
    var todayOpeningHours: String
    var services: [WorkshopService]
    var address: WorkshopAddress
}
