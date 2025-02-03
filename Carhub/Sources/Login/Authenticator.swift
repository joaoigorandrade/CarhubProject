//
//  Authenticator.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 29/12/24.
//

import SwiftUI

class Authenticator: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var userType: UserType?
    
    func receiveAuthentication(_ authentication: Authentication) {
        isAuthenticated = authentication.isAuthenticated
        userType = authentication.userType
    }
}
