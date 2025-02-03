//
//  APIError.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 28/12/24.
//

import Foundation

public enum APIError: Error {
    case invalidRequest(String)
    case networkError(Error)
    case serverError(statusCode: Int, data: Data?)
    case decodingError(Error)
    case unknown(Error?)
}
