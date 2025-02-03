//
//  WorkshopServices.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 07/01/25.
//

enum WorkshopService: String, Codable, CaseIterable {
    case oilChange = "Troca de Óleo"
    case tireRotation = "Rodízio de Pneus"
    case brakeInspection = "Inspeção de Freios"
    case wheelAlignment = "Alinhamento de Rodas"
    case batteryReplacement = "Substituição de Bateria"
    case engineDiagnostics = "Diagnóstico do Motor"
    case airConditioningService = "Serviço de Ar Condicionado"
    case transmissionRepair = "Reparo de Transmissão"
    case exhaustRepair = "Reparo de Escape"
    case suspensionRepair = "Reparo de Suspensão"
    case coolantFlush = "Troca de Fluido de Arrefecimento"
    case windshieldReplacement = "Substituição de Para-brisa"
    case detailingService = "Serviço de Detalhamento"
    case carWash = "Lavagem de Carro"
    case headlightRestoration = "Restauração de Faróis"
    case cabinAirFilterReplacement = "Substituição do Filtro de Ar da Cabine"
    case prePurchaseInspection = "Inspeção Pré-Compra"
    case emergencyTowing = "Reboque de Emergência"
    case glassRepair = "Reparo de Vidros"
    case electricalSystemRepair = "Reparo do Sistema Elétrico"
    case hybridSystemMaintenance = "Manutenção do Sistema Híbrido"
    case emissionsTesting = "Teste de Emissões"
    case generalInspection = "Inspeção Geral"

    var image: String {
        switch self {
        case .oilChange: return "oilcan.fill"
        case .tireRotation: return "arrow.triangle.2.circlepath"
        case .brakeInspection: return "car.badge.gearshape.fill"
        case .wheelAlignment: return "wrench.and.screwdriver.fill"
        case .batteryReplacement: return "bolt.car.fill"
        case .engineDiagnostics: return "cpu"
        case .airConditioningService: return "snowflake"
        case .transmissionRepair: return "gearshape.fill"
        case .exhaustRepair: return "smoke.fill"
        case .suspensionRepair: return "car.2.fill"
        case .coolantFlush: return "drop.fill"
        case .windshieldReplacement: return "rectangle.dashed"
        case .detailingService: return "paintbrush.fill"
        case .carWash: return "cloud.rain.fill"
        case .headlightRestoration: return "lightbulb.fill"
        case .cabinAirFilterReplacement: return "wind"
        case .prePurchaseInspection: return "magnifyingglass"
        case .emergencyTowing: return "car.fill"
        case .glassRepair: return "rectangle.on.rectangle.angled"
        case .electricalSystemRepair: return "bolt.fill"
        case .hybridSystemMaintenance: return "leaf.fill"
        case .emissionsTesting: return "aqi.high"
        case .generalInspection: return "doc.text.magnifyingglass"
        }
    }
}
