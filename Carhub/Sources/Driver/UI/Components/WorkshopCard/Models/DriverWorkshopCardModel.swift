//
//  DriverWorkshopCardModel.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 29/12/24.
//

struct DriverWorkshopCardModel: Codable, Identifiable {
    let name: String
    let id: Int
    let image: String
    let positives: Int
    let negatives: Int
    let comments: Int
    let distance: Double
    let address: String
    let price: Int
    let services: [WorkshopService]
}
