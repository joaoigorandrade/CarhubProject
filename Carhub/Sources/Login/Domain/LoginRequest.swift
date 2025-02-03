//
//  LoginRequest.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 29/12/24.
//

enum LoginRequest: APIRequest {
    
    case signIn(_ credentials: Credentials)
    case signUp(_ credentials: Credentials)
    
    var path: String {
        switch self {
        case .signIn: "/login"
        case .signUp: "/signup"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .signIn, .signUp: .post
        }
    }
    
    var headers: [String : String]? {
        nil
    }
    
    var queryParameters: [String : Any]? {
        switch self {
        default: nil
        }
    }
    
    var bodyParameters: [String : Any]? {
        switch self {
        case .signIn(let credentials),
                .signUp(let credentials): credentials.toDictionary()
        }
    }
}
