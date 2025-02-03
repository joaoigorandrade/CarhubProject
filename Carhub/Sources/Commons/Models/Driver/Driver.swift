//
//  Driver.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 29/12/24.
//

struct Driver: Codable {
    var id: String
    var name: String
    var email: String
    var photo: String
    var phone: String
    var type: UserType = .driver
}

