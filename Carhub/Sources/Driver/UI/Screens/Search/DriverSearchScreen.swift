//
//  DriverSearchScreen.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 29/12/24.
//

import SwiftUI

struct DriverSearchScreen: View {
    
    @EnvironmentObject private var router: DriverScreenRouter
    @StateObject var viewModel: DriverSearchScreenViewModel = .init()
    
    var body: some View {
        view
            .onAppear {
                viewModel.triggerInitialSearch()
            }
            .task {
                await viewModel.performInitialSearch()
            }
    }
    
    @ViewBuilder
    var view: some View {
        switch viewModel.viewState {
        case .loading:
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .loaded:
            content
        case .error(let error):
            ErrorView(error: error.description)
        }
    }
    
    @ViewBuilder
    var search: some View {
        HStack(spacing: 4) {
            SearchBar(searchText: $viewModel.searchText, onSearchAction: { })
            Menu {
                ForEach(DriverFilterOptions.allCases, id: \.self) { option in
                    Button(option.rawValue) {
                        viewModel.filterOption = option
                    }
                }
            } label: {
                Image(systemName: viewModel.filterOption.image)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(Color(.systemGray))
                    .padding(.leading)
            }
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    var list: some View {
        RefreshableScrollView {
            cards
        } onRefresh: {
            await viewModel.performInitialSearch()
        }
    }
    
    @ViewBuilder
    var cards: some View {
        ForEach(viewModel.filteredOptions) { model in
            Button {
                router.navigate(to: .workshopDetails(id: model.id))
            } label: {
                DriverWorkshopCard(model: model)
                    .contentShape(Rectangle())
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
        }
    }
    
    @ViewBuilder
    var content: some View {
        ScrollView {
            LazyVStack(pinnedViews: .sectionHeaders) {
                Section {
                    list
                } header: {
                    search
                        .padding(.vertical)
                        .background(Color(.systemBackground))
                }
            }
        }
    }
}
