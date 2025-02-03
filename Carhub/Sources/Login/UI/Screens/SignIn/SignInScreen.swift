//
//  SignInScreen.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 29/12/24.
//

import SwiftUI

struct SignInScreen: View {
    
    @StateObject var viewModel: SignInScreenViewModel
    @EnvironmentObject var authenticator: Authenticator
    
    init() {
        self._viewModel = .init(wrappedValue: .init())
    }
    
    var body: some View {
        VStack(spacing: 16) {
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button {
                Task {
                    let auth = await viewModel.signIn()
                    authenticator.receiveAuthentication(auth)
                }
            } label: {
                Text("Sign In")
            }
        }
    }
}
