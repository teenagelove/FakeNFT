//
//  BoughtNfts.swift
//  iOS-FakeNFT-Extended
//
//  Created by 1111 on 17.09.2025.
//

import SwiftUI

struct BoughtNft: View {
    let imageName: String
    let name: String
    let rating: Int
    let price: Double
    
    private var editedPrice: String {
        String(price).replacingOccurrences(of: ".", with: ",")
    }
    
    var body: some View {
        HStack(spacing: .zero) {
            Image(imageName).frame(width: 108, height: 108)
            Spacer()
            HStack(spacing: .zero) {
                VStack(alignment: .leading, spacing: .zero) {
                    Text(name)
                        .font(.bodyBold)
                        .padding(.bottom, 4)
                    StarRatingView(rating: rating)
                        .frame(maxWidth: 68, maxHeight: 12)
                        .padding(.bottom, 12)
                    Text("Price")
                        .font(.caption2)
                        .padding(.bottom, 2)
                    Text(editedPrice + " ETH").font(.bodyBold)
                }
                .padding(.leading, 20)
                .padding([.vertical], 8)
                Spacer()
                Button {} label: {
                    Image(.deleteItem)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(16)
    }
}

#Preview {
    BoughtNft(
        imageName: MockBoughtNft.mockData[0].imageName,
        name: MockBoughtNft.mockData[0].name,
        rating: MockBoughtNft.mockData[0].rating,
        price: MockBoughtNft.mockData[0].price
    )
}
