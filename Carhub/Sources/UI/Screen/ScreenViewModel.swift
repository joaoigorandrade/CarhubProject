//
//  ScreenViewModel.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 03/02/25.
//

import SwiftUI

protocol ScreenViewModel: ObservableObject {
    var viewState: ScreenState { get set }
}
