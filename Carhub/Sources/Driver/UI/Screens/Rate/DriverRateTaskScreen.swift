//
//  DriverRateTaskScreen.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 29/12/24.
//

import SwiftUI

struct DriverRateTaskScreen: View {
    
    @EnvironmentObject private var router: DriverScreenRouter
    @StateObject var viewModel: DriverRateTaskScreenViewModel
        
    var body: some View {
        view
            .task {
                await viewModel.fetch()
            }
            .navigationTitle(viewModel.response?.workshop.name ?? "")
            .navigationBarTitleDisplayMode(.large)
            .alert("Avalidado com sucesso", isPresented: $viewModel.alert) {
                Button {
                    viewModel.alert = true
                    router.pop()
                } label: {
                    Text("Ok")
                }
            }

    }
    
    @ViewBuilder
    var view: some View {
        switch viewModel.state {
        case .loading: ProgressView()
        case .loaded: content
        case .error(let error): ErrorView(error: error)
        }
    }
    
    @ViewBuilder
    var content: some View {
        VStack {
            image
            workshop
            rate
            Spacer()
        }
    }
    
    @ViewBuilder
    var image: some View {
        AsyncImage(url: URL(string: viewModel.response?.workshop.photoURL ?? "")) { image in
            image
                .resizable()
                .scaledToFill()
                .frame(height: 220)
                .clipped()
        } placeholder: {
            ProgressView()
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(height: 220)
                .foregroundColor(Color(UIColor.systemGray4))
        }
    }
    
    @ViewBuilder
    var workshop: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: WorkshopService.airConditioningService.image)
                Text(WorkshopService.airConditioningService.rawValue)
                    .font(.headline)
                    .bold()
                Spacer()
                Text(viewModel.response?.service.forecast ?? "")
                    .font(.subheadline)
            }
            .padding(.top, 16)
        }
        .padding(.horizontal, 16)
    }
    
    var rate: some View {
        VStack {
            TextEditor(text: $viewModel.textfieldText)
                .padding(8)
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.top, 16)
            HStack {
                Text("Avaliar")
                    .font(.headline)
                    .bold()
                    .padding(.top, 16)
                Spacer()
                HStack(spacing: 24) {
                    Button {
                        viewModel.alert = true
                    } label: {
                        Image(systemName: "hand.thumbsup.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(Color(UIColor.systemGray))
                    }
                    Button {
                        viewModel.alert = true
                    } label: {
                        Image(systemName: "hand.thumbsdown.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(Color(UIColor.systemGray))
                    }
                }
                .padding(.horizontal, 24)
            }
        }
        
    }
}
