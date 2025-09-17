//
//  BasketView.swift
//  iOS-FakeNFT-Extended
//
//  Created by 1111 on 16.09.2025.
//

import SwiftUI

struct BasketView: View {
    private let mockNft = [
        MockBoughtNft(imageName: "mockBoughtImagesNft1", name: "April", rating: "mockRatingOfBoughtNft1", price: 1.78),
        MockBoughtNft(imageName: "mockBoughtImagesNft2", name: "Greena", rating: "mockRatingOfBoughtNft2", price: 1.78),
        MockBoughtNft(imageName: "mockBoughtImagesNft3", name: "Spring", rating: "mockRatingOfBoughtNft3", price: 1.78)
    ]
    private var basketSum: String {
        var basketSum: Double = 0
        mockNft.forEach { item in
            basketSum = basketSum + item.price
        }
        
        var stringBasketSum = ""
        for character in String(basketSum) {
            if character == "." {
                stringBasketSum += ","
            } else {
                stringBasketSum += String(character)
            }
        }
        return stringBasketSum
    }
    
    var body: some View {
        VStack(spacing: .zero) {
            HStack(spacing: .zero) {
                Spacer()
                Button {} label: {
                    Image(.sortIcon)
                }
                .frame(width: 42, height: 42)
                .padding(.trailing, 9)
                .padding(.top, 2)
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 20)
            List(mockNft, id: \.self) { boughtNft in
                BoughtNft(imageName: boughtNft.imageName, name: boughtNft.name, rating: boughtNft.rating, price: boughtNft.price)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
            }
            .listStyle(.plain)
            Spacer()
            ZStack {
                UnevenRoundedRectangle(topLeadingRadius: 12, topTrailingRadius: 12)
                    .foregroundStyle(.lightGrey)
                    .frame(maxWidth: .infinity, maxHeight: 76)
                HStack(spacing: .zero) {
                    VStack(alignment: .leading, spacing: .zero) {
                        Text(String(mockNft.count) + " NFT")
                            .font(.system(size: 15,weight: .regular))
                        Text(String(basketSum) + " ETH")
                            .foregroundStyle(.green)
                            .font(.system(size: 17, weight: .bold))
                    }
                    .padding(.leading, 16)
                    Button("For.payment") {
                    }
                    .frame(maxWidth: .infinity, maxHeight: 44)
                    .font(.system(size: 17, weight: .bold))
                    .background(.black)
                    .foregroundStyle(.white)
                    .cornerRadius(16)
                    .padding(.trailing, 16)
                    .padding(.leading, 24)
                }
            }
        }.frame(maxWidth: .infinity)
    }
}

//#Preview {
//    BasketView()
//}

private struct BoughtNft: View {
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
            Image(imageName)
                .frame(width: 108, height: 108)
            Spacer()
            HStack(spacing: .zero) {
                VStack(alignment: .leading, spacing: .zero) {
                    Text(name)
                        .font(.system(size: 17, weight: .bold))
                        .padding(.bottom, 4)
                    Image(rating).padding(.bottom, 12)
                    Text("Цена")
                        .font(.system(size: 13, weight: .regular))
                        .padding(.bottom, 2)
                    Text(editedPrice + " ETH")
                        .font(.system(size: 17, weight: .bold))
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

private struct MockBoughtNft: Hashable {
    let imageName: String
    let name: String
    let rating: String
    let price: Double
}
