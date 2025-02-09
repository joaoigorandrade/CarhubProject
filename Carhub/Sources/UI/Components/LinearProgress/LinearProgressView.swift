//
//  LinearProgressView.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 05/02/25.
//

import SwiftUI

struct LinearProgressView<CurrentShape: Shape>: View {
    let value: Double
    let shape: CurrentShape
    let firstColor: Color
    let secondColor: Color
    
    init(value: Double, shape: CurrentShape) {
        self.value = value
        self.shape = shape
        firstColor = .green
        secondColor = .gray
    }
    
    init(model: LinearProgressModel, shape: CurrentShape) {
        let value = model.firstValue + model.secondValue
        self.value = Double(model.firstValue) / Double(value)
        self.shape = shape
        self.firstColor = model.firstColor
        self.secondColor = model.secondColor
    }

    var body: some View {
        shape.fill(secondColor)
             .overlay(alignment: .leading) {
                 GeometryReader { proxy in
                     shape.fill(firstColor)
                          .frame(width: proxy.size.width * value)
                 }
             }
             .clipShape(shape)
    }
}

struct LinearProgressModel {
    let firstValue: Int
    let secondValue: Int
    let firstColor: Color
    let secondColor: Color
}
