//
//  WorkshopScheduleAvailableTimesRequest.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 09/02/25.
//

import Foundation

struct WorkshopScheduleAvailableTimesRequest: Codable {
    let id: Int
    let date: String
    
    init(id: Int, date: Date) {
        self.id = id
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        self.date = dateFormatter.string(from: date)
    }
}
