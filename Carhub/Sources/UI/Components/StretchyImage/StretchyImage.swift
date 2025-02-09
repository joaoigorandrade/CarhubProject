//
//  StretchyImage.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 06/02/25.
//

import SwiftUI

struct StretchyImage: View {
    let imageURL: URL?
    
    var body: some View {
        GeometryReader { geometry in
            AsyncImage(url: imageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea(edges: .all)
            } placeholder: {
                ProgressView()
            }
            .frame(maxWidth: .infinity, maxHeight: self.calculateHeight(geometry))
            .offset(y: self.calculateOffset(geometry))
        }
    }
    
    private func calculateHeight(_ geometry: GeometryProxy) -> CGFloat {
        let yOffset = geometry.frame(in: .local).minY
        return geometry.size.height + (yOffset > 0 ? yOffset : 0)
    }
    
    private func calculateOffset(_ geometry: GeometryProxy) -> CGFloat {
        let yOffset = geometry.frame(in: .global).minY
        return yOffset > 0 ? -yOffset / 2 : 0
    }
    
}
