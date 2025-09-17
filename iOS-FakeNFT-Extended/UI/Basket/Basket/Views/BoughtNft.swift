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
    let rating: String
    let price: Double
    
    private var editedPrice: String {
        var editedPrice = ""
        for character in String(price) {
            if character == "." {
                editedPrice += ","
            } else {
                editedPrice += String(character)
            }
        }
        return editedPrice
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
                    Image(rating).padding(.bottom, 12)
                    Text(NSLocalizedString("Price", comment: ""))
                        .font(.caption2)
                        .padding(.bottom, 2)
                    Text(editedPrice + " ETH").font(.bodyBold)
                }
                .padding(.leading, 20)
                .padding([.top, .bottom], 8)
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
