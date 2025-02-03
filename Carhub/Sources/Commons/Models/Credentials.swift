//
//  Credentials.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 29/12/24.
//

protocol Credentials: Codable {
    var email: String { get }
    var password: String { get }
}
