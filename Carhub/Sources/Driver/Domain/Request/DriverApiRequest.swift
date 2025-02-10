//
//  DriverApiRequest.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 28/12/24.
//

import Foundation

enum DriverApiRequest: APIRequest {
    
    case getHomePage
    case postPositiveRate(id: Int)
    case postSearchOptions(model: DriverSearchScreenRequest)
    case getWorkshop(id: Int)
    case getWorkshopComments(id: Int)
    case postSchedule(model: WorkshopScheduleRequest)
    case getSchedule(model: WorkshopScheduleAvailableTimesRequest)
    case getRateScreen(id: Int)
    
    var baseURL: URL {
        guard let url = URL(string: "http://localhost:3000") else { fatalError() }
        return url
    }
    
    var path: String {
        switch self {
        case .getHomePage: "/services"
        case .postPositiveRate: "/rate"
        case .postSearchOptions: "/workshops"
        case .getWorkshop: "/workshop"
        case .getWorkshopComments: "/comments"
        case .postSchedule: "/schedule"
        case .getSchedule: "/schedule/available-times"
        case .getRateScreen: "/rate"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getHomePage, .getWorkshop, .getWorkshopComments, .getRateScreen, .getSchedule: .get
        case .postPositiveRate, .postSearchOptions,.postSchedule: .post
        }
    }
    
    var headers: [String : String]? {
        [:]
    }
    
    var queryParameters: [String : Any]? {
        switch self {
        case .getHomePage: nil
        case .postPositiveRate: nil
        case .postSearchOptions: nil
        case .getWorkshop(let id): ["id": id]
        case .getWorkshopComments(let id): ["id": id]
        case .postSchedule: nil
        case .getSchedule(let model): ["id": model.id, "date": model.date]
        case .getRateScreen(let id): ["id": id]
        }
    }
    
    var bodyParameters: [String : Any]? {
        switch self {
        case .getHomePage, .getWorkshop, .getWorkshopComments, .getRateScreen, .getSchedule: nil
        case .postPositiveRate(id: let id): ["id": id, "type": "positive"]
        case .postSearchOptions(let model): model.toDictionary()
        case .postSchedule(let model): model.toDictionary()
        }
    }
}
