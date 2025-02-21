//
//  ScreenState.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 29/12/24.
//

enum ScreenState: Equatable {
    case loading
    case loaded
    case error(_ error: String)
}
