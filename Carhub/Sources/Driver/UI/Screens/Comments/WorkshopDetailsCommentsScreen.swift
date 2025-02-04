//
//  WorkshopDetailsCommentsScreen.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 12/01/25.
//

import SwiftUI

struct WorkshopDetailsCommentsScreen: View {
    
    @StateObject var viewModel: WorkshopDetailsCommentsScreenViewModel
        
    var body: some View {
        view
            .task {
                await viewModel.fetch()
            }
    }
    
    @ViewBuilder
    var view: some View {
        switch viewModel.viewState {
        case .loading: ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        case .loaded: content
        case .error(let error): ErrorView(error: error)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
    
    @ViewBuilder
    var content: some View {
        List {
            ForEach(viewModel.comments) { comment in
                HStack {
                    Image(systemName: "person.fill")
                        .padding(16)
                    VStack(alignment: .leading, spacing: 8) {
                        Text(comment.author)
                            .font(.subheadline)
                            .bold()
                        if !comment.text.isEmpty {
                            Text(comment.text)
                                .font(.caption)
                        }
                        Text(comment.date)
                            .font(.caption)
                    }
                    Spacer()
                    Image(systemName: comment.rating.image)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(comment.rating.color)
                }
            }
        }
        .listStyle(.plain)
    }
}
