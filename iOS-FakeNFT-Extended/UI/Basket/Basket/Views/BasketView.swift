//
//  BasketView.swift
//  iOS-FakeNFT-Extended
//
//  Created by 1111 on 16.09.2025.
//

import SwiftUI

struct BasketView: View {
    private var basketSum: String {
        var basketSum: Double = 0
        MockBoughtNft.mockData.forEach { item in
            basketSum += item.price
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
        NavigationStack {
            if MockBoughtNft.mockData.count == 0 {
                Text(NSLocalizedString("EmptyBasket", comment: "")).font(.system(size: 17, weight: .bold))
            } else {
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
                    List(MockBoughtNft.mockData, id: \.self) { boughtNft in
                        BoughtNft(imageName: boughtNft.imageName, name: boughtNft.name, rating: boughtNft.rating, price: boughtNft.price)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets())
                    }.listStyle(.plain)
                    Spacer()
                    ZStack {
                        UnevenRoundedRectangle(topLeadingRadius: 12, topTrailingRadius: 12)
                            .foregroundStyle(.lightGrey)
                            .frame(maxWidth: .infinity, maxHeight: 76)
                        HStack(spacing: .zero) {
                            VStack(alignment: .leading, spacing: .zero) {
                                Text(String(MockBoughtNft.mockData.count) + " NFT").font(.caption1)
                                Text(String(basketSum) + " ETH")
                                    .foregroundStyle(.green)
                                    .font(.bodyBold)
                            }.padding(.leading, 16)
                            NavigationLink(NSLocalizedString("For.payment", comment: "")) {
                                CurrencyChooseView().toolbar(.hidden, for: .tabBar)
                            }
                            .frame(maxWidth: .infinity, maxHeight: 44)
                            .font(.bodyBold)
                            .background(.black)
                            .foregroundStyle(.white)
                            .cornerRadius(16)
                            .padding(.trailing, 16)
                            .padding(.leading, 24)
                        }
                    }
                }.frame(maxWidth: .infinity)
            }
        }.tint(.black)
    }
}

#Preview {
    BasketView()
}
