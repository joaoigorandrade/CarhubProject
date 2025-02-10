//
//  WorkshopServicesCategories.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 09/02/25.
//

enum WorkshopServiceCategory: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case maintenance = "Manutenção"
    case repair = "Reparos"
    case inspection = "Inspeções"
    case personalization = "Personalização"
    case cleaning = "Limpeza"
    case emergency = "Emergência"
}
