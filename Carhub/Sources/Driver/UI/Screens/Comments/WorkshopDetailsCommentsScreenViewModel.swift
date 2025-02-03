//
//  WorkshopDetailsCommentsScreenViewModel.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 12/01/25.
//

import SwiftUI

class WorkshopDetailsCommentsScreenViewModel: ObservableObject {
    
    let id: Int
    let useCase: WorkshopDetailsCommentsScreenUseCase = .init()

    @Published var viewState: ScreenState = .loading
    @Published var comments: [WorkshopDetailsComment] = []
    
    init(id: Int) {
        self.id = id
        print("init \(type(of: self))")
    }
    
    deinit {
        print("de init \(type(of: self))")
    }
        
    @MainActor
    func fetchComments() async {
        do {
            comments = try await useCase.fetchComments(id: id)
            viewState = .loaded
        } catch {
            viewState = .error("No comments found")
        }
    }
}
