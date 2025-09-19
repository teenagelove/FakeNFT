//
//  BasketView.swift
//  iOS-FakeNFT-Extended
//
//  Created by 1111 on 16.09.2025.
//

import SwiftUI

struct BasketView: View {
    @State var isHidden = false
    
    private var basketSum: String {
        var basketSum: Double = 0
        MockBoughtNft.mockData.forEach { item in
            basketSum += item.price
        }
        
        return String(basketSum).replacingOccurrences(of: ".", with: ",")
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Text("EmptyBasket")
                    .font(.system(size: 17, weight: .bold))
                    .opacity(isHidden ? 1 : 0)
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
                            NavigationLink("For.payment") {
                                CurrencyChooseView().toolbar(.hidden, for: .tabBar)
                            }
                            .frame(maxWidth: .infinity, maxHeight: 44)
                            .font(.bodyBold)
                            .background(.black)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .padding(.trailing, 16)
                            .padding(.leading, 24)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .opacity(isHidden ? 0 : 1)
            }
        }.tint(.black)
    }
}

#Preview {
    BasketView()
}
