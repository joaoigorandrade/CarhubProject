//
//  DriverTaskCard.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 29/12/24.
//

import SwiftUI

struct DriverTaskCard: View {
    @EnvironmentObject private var router: DriverScreenRouter
    let workShopTask: WorkshopTask
    
    var body: some View {
        Button {
            router.navigate(to: .rateTask(id: workShopTask.id))
        } label: {
            HStack {
                AsyncImage(url: URL(string: workShopTask.workShopPhoto)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                } placeholder: {
                    Image(systemName: "tire")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundStyle(Color(.systemGray4))
                }
                .padding(8)

                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        Image(systemName: workShopTask.name.image)
                        Text(workShopTask.name.rawValue)
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .lineLimit(2)
                        Spacer(minLength: 16)
                        Text("\(workShopTask.forecast)")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .lineLimit(2)
                    }
                    Spacer(minLength: 0)
                    HStack {
                        if workShopTask.status == .done {
                            Text("Avaliar")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .lineLimit(1)
                                .foregroundStyle(.blue)
                        }
                        Spacer()
                        Text(workShopTask.workShopName)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .lineLimit(2)
                    }
                }
                .padding(16)
                Spacer()
                Rectangle()
                    .foregroundStyle(workShopTask.status.color)
                    .frame(width: 9)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemBackground))
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                
            )
            .frame(maxWidth: .infinity)
            .frame(height: 160)
        }
        .foregroundStyle(.primary)
    }
}
