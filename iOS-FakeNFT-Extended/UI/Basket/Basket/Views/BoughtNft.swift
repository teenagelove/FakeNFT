//
//  BoughtNfts.swift
//  iOS-FakeNFT-Extended
//
//  Created by 1111 on 17.09.2025.
//

import SwiftUI

struct BoughtNft: View {
    @Bindable var viewModel: BasketViewModel
    
    let boughtNftModel: Nft
    
    private var editedPrice: String {
        String(boughtNftModel.price).replacingOccurrences(of: ".", with: ",")
    }
    
    var body: some View {
        HStack(spacing: .zero) {
            AsyncImage(url: boughtNftModel.images.first) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
                .frame(width: 108, height: 108)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            Spacer()
            HStack(spacing: .zero) {
                VStack(alignment: .leading, spacing: .zero) {
                    Text(boughtNftModel.name)
                        .font(.bodyBold)
                        .padding(.bottom, 4)
                    StarRatingView(rating: boughtNftModel.rating)
                        .frame(maxWidth: 68, maxHeight: 12)
                        .padding(.bottom, 12)
                    Text("Price")
                        .font(.caption2)
                        .padding(.bottom, 2)
                    Text(editedPrice + " ETH").font(.bodyBold)
                }
                .padding(.leading, 20)
                .padding(.vertical, 8)
                Spacer()
                Button {
                    viewModel.idOfBoughtNftToDelete = boughtNftModel.id
                    viewModel.isDeleteItemViewShown = true
                } label: {
                    Image(.deleteItem).foregroundColor(.blackDay)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(16)
    }
}

#Preview {
    BoughtNft(
        viewModel: BasketViewModel(
            services: ServicesAssembly(networkClient: DefaultNetworkClient(),
                                       nftStorage: NftStorageImpl()
                                      )
        ),
        boughtNftModel: Nft(
            name: "Terry",
            rating: 3,
            price: 30,
            id: "1",
            images: [URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Blue/Bonnie/1.png")!]
        )
    )
}
