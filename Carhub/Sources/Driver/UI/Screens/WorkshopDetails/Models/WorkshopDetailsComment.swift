//
//  WorkshopDetailsComment.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 03/02/25.
//

struct WorkshopDetailsComment: Codable, Identifiable, Hashable {
    var id: Int
    var text: String
    var author: String
    var date: String
    var rating: WorkshopRateType
}
