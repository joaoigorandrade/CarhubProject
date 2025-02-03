//
//  DriverWorkshopCard.swift
//  Carhub
//
//  Created by Joao Igor de Andrade Oliveira on 29/12/24.
//

import SwiftUI

struct DriverWorkshopCard: View {
    let model: DriverWorkshopCardModel
    
    var body: some View {
        HStack(spacing: 8) {
            HStack(alignment: .center, spacing: 16) {
                AsyncImage(url: URL(string: model.image)) { image in
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
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack(alignment: .top, spacing: 16) {
                        Text(model.name)
                            .font(.headline)
                            .lineLimit(2)
                            .foregroundColor(.primary)
                        Spacer()
                        HStack(spacing: 4) {
                            ForEach(0..<5, id: \.self) { index in
                                Image(systemName: "dollarsign.circle.fill")
                                    .resizable()
                                    .frame(width: 12, height: 12)
                                    .foregroundColor(index < model.price ? .yellow : .gray)
                            }
                        }
                    }
                    VStack(alignment: .leading) {
                        HStack {
                            Text(model.address)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .lineLimit(2)
                            Spacer()
                            VStack(alignment: .leading, spacing: 4) {
                                HStack(spacing: 4) {
                                    Image(systemName: "hand.thumbsup.fill")
                                        .resizable()
                                        .foregroundStyle(.secondary)
                                        .frame(width: 12, height: 12)
                                    Text("\(model.positives)")
                                        .font(.footnote)
                                        .foregroundColor(.secondary)
                                }
                                HStack(spacing: 4) {
                                    Image(systemName: "hand.thumbsdown.fill")
                                        .resizable()
                                        .foregroundStyle(.secondary)
                                        .frame(width: 12, height: 12)
                                    Text("\(model.negatives)")
                                        .font(.footnote)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        Spacer(minLength: 0)
                        HStack {
                            HStack {
                                ForEach(model.services, id: \.self) { service in
                                    Image(systemName: service.image)
                                        .resizable()
                                        .frame(width: 16, height: 16)
                                }
                            }
                            Spacer(minLength: 0)
                            HStack(alignment: .top, spacing: 4) {
                                Image(systemName: "bubble.left.fill")
                                    .resizable()
                                    .frame(width: 16, height: 16)
                                Text("\(model.comments)")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                
            }
            .padding(.vertical, 16)
            .padding(.leading, 8)
            Rectangle()
                .foregroundStyle(.secondary)
                .frame(width: 9)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
            
        )
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
        .frame(height: 160)
    }
}

#Preview {
    DriverWorkshopCard(model: DriverWorkshopCardModel(name: "Oficina do Paulão",
                                                      id: 1,
                                                      image: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fpt.vecteezy.com%2Fpng-gratis%2Flogotipo&psig=AOvVaw2Nzb9vtwSoOl_gsSDkpPbA&ust=1735600583176000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCMDonpSOzooDFQAAAAAdAAAAABAE",
                                                      positives: 1231,
                                                      negatives: 83,
                                                      comments: 43,
                                                      distance: 23.3,
                                                      address: "R. António de Almeida, 42, Boa Vista",
                                                      price: 2,
                                                      services: [.airConditioningService, .batteryReplacement]))
}
