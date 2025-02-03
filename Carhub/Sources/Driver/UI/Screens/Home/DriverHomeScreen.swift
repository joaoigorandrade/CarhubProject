//
//  DriverHomeScreen.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 29/12/24.
//

import SwiftUI

struct DriverHomeScreen: View {
    @EnvironmentObject private var router: DriverScreenRouter
    @StateObject private var viewModel: DriverHomeScreenViewModel = .init()
        
    var body: some View {
        view
            .task {
                await viewModel.fetchJobs()
            }
            .animation(.easeInOut, value: viewModel.viewState)
    }
    
    @ViewBuilder
    var view: some View {
        switch viewModel.viewState {
        case .loading: ProgressView()
        case .loaded: loadedView.padding(.horizontal, 24)
        case .error(let error): ErrorView(error: error)
        }
    }
        
    @ViewBuilder
    var loadedView: some View {
        RefreshableScrollView {
            Group {
                if viewModel.tasks.isEmpty {
                    Text("No jobs yet")
                } else {
                    ForEach(viewModel.tasks) { job in
                        DriverTaskCard(workShopTask: job)
                    }
                }
            }
        } onRefresh: {
            await viewModel.fetchJobs(force: true)
        }
    }
}
