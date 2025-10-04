//
//  BoughtNfts.swift
//  iOS-FakeNFT-Extended
//
//  Created by 1111 on 17.09.2025.
//

import SwiftUI
import Kingfisher

struct BoughtNft: View {
    @Bindable var viewModel: BasketViewModel
    
//    let boughtNftModel: MockBoughtNftModel
    let boughtNftModel: Nft
    
    private var editedPrice: String {
        String(boughtNftModel.price).replacingOccurrences(of: ".", with: ",")
    }
    
    var body: some View {
        HStack(spacing: .zero) {
            KFImage(boughtNftModel.images.first)
                .resizable()
                .scaledToFill()
                .frame(width: 108, height: 108)
//            Image(boughtNftModel.imageName).frame(width: 108, height: 108)
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
                    Image(.deleteItem)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(16)
    }
}

//#Preview {
//    BoughtNft(
//        viewModel: BasketViewModel(),
//        boughtNftModel: MockBoughtNftModel(
//            imageName: "mockBoughtImagesNft1",
//            name: "April",
//            rating: 1,
//            price: 1.78
//        )
//    )
//}
