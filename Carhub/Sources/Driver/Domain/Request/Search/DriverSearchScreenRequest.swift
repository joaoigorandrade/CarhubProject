//
//  DriverSearchScreenRequest.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 12/01/25.
//

struct DriverSearchScreenRequest: Codable {
    let seachTerm: String
    let orderBy: DriverFilterOptions
}
