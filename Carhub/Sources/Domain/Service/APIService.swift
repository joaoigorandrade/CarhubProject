//
//  APIService.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 28/12/24.
//

import Foundation

public final class APIClient<Request: APIRequest> {
    
    private let urlSession: URLSession
    
    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    public func sendRequest<T: Decodable>(_ request: Request) async throws -> T {
        
        let url = try buildURL(from: request)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue

        if let headers = request.headers {
            for (headerField, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: headerField)
            }
        }
        
        if let bodyParameters = request.bodyParameters,
           request.method == .post || request.method == .put {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: bodyParameters, options: [])
        }
        
        do {
            print(urlSession)
            let (data, response) = try await urlSession.data(for: urlRequest)
            let decodedResponse = try APIResponseHandler.parseResponse(data, response, as: T.self)
            return decodedResponse
        } catch let error as APIError {
            throw error
        } catch {
            throw APIError.networkError(error)
        }
    }
    
    private func buildURL(from request: Request) throws -> URL {
        guard let baseURL = URL(string: "http://localhost:3000") else { fatalError() }
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        urlComponents?.path += request.path
        
        if let queryParameters = request.queryParameters, !queryParameters.isEmpty {
            var queryItems: [URLQueryItem] = []
            for (key, value) in queryParameters {
                queryItems.append(URLQueryItem(name: key, value: "\(value)"))
            }
            urlComponents?.queryItems = queryItems
        }
        
        guard let finalURL = urlComponents?.url else {
            throw APIError.invalidRequest("Failed to construct URL from baseURL: \(baseURL) and path: \(request.path)")
        }
        
        return finalURL
    }
}
