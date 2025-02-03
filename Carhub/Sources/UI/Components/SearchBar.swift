//
//  SearchBar.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 29/12/24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    
    @FocusState var isEditing: Bool
    
    var placeholder: String = "Buscar"
    var onSearchTextChanged: ((String) -> Void)?
    var onSearchAction: (() -> Void)?
    var onCancel: (() -> Void)?
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField(placeholder, text: $searchText, onCommit: {
                onSearchAction?()
            })
            .autocorrectionDisabled()
            .foregroundColor(.primary)
            .focused($isEditing)
            .onTapGesture {
                withAnimation(.spring()) {
                    isEditing = true
                }
            }
            .onChange(of: searchText) { _, newValue in
                onSearchTextChanged?(newValue)
            }
            
            if isEditing {
                Button {
                    withAnimation(.spring()) {
                        isEditing = false
                        searchText = ""
                    }
                    onCancel?()
                    UIApplication.shared.endEditing()
                } label: {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                .padding(.trailing, 8)
                .transition(.opacity)
            }
        }
        .padding(8)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .shadow(color: isEditing ? .black.opacity(0.2) : .clear, radius: 3, x: 0, y: 2)
        .scaleEffect(isEditing ? 1.05 : 1.0)
        .animation(.easeInOut, value: isEditing)
    }
}

// Utility to dismiss keyboard
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    SearchBar(searchText: .constant(""))
}
