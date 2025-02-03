//
//  DriverFilterOptions.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 29/12/24.
//

enum DriverFilterOptions: String, Codable, CaseIterable {
    case rating = "Most Positives"
    case distance = "Distance"
    case higherPrice = "Higher Price"
    case lowerPrice = "Lower Price"
    
    var image: String {
        switch self {
        case .rating: "star.fill"
        case .distance: "mappin.and.ellipse.circle.fill"
        case .higherPrice: "arrow.up.circle.fill"
        case .lowerPrice: "arrow.down.circle.fill"
        }
    }
}
