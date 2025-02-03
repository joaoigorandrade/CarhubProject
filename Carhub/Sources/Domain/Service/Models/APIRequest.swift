//
//  APIRequest.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 28/12/24.
//

import Foundation

public protocol APIRequest {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryParameters: [String: Any]? { get }
    var bodyParameters: [String: Any]? { get }
}

