//
//  APIResponseHandler.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 28/12/24.
//

import Foundation

public struct APIResponseHandler {

    public static func parseResponse<T: Decodable>(_ data: Data, _ response: URLResponse?, as type: T.Type) throws -> T {
        
        if let httpResponse = response as? HTTPURLResponse {
            let statusCode = httpResponse.statusCode
            guard 200..<300 ~= statusCode else {
                throw APIError.serverError(statusCode: statusCode, data: data)
            }
        }
        
        do {
            let decodedObject = try JSONDecoder().decode(T.self, from: data)
            return decodedObject
        } catch {
            throw APIError.decodingError(error)
        }
    }
}
