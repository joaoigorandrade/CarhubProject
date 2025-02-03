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
        homeView
            .padding(.horizontal, 24)
    }
    @ViewBuilder
    var homeView: some View {
        switch viewModel.state {
        case .loading: ProgressView()
        case .loaded: loadedView
        case .error(let error): Text("Error: \(error)")
        }
    }
    
    @ViewBuilder
    var loadedView: some View {
        if viewModel.tasks.isEmpty {
            Text("No jobs yet")
        } else {
            RefreshableScrollView {
                ForEach(viewModel.tasks) { job in
                    DriverTaskCard(workShopTask: job)
                }
            } onRefresh: {
                await viewModel.fetchJobs(force: true)
            }

        }
    }
}
