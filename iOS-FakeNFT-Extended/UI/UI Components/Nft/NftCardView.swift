//
//  NftCardView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 15.09.2025.
//

import SwiftUI
import Kingfisher

struct NftCardView: View {
    let nft: Nft
    
    var body: some View {
        VStack(spacing: 8) {
            nftImage
            nftInfo
        }
    }
}

private extension NftCardView {
    
    var nftImage: some View {
        ZStack(alignment: .topTrailing) {
            KFImage(nft.images.first)
                .fade(duration: 0.3)
                .placeholder { SkeletonView() }
                .resizable()
                .scaledToFit()
                .clipShape(.rect(cornerRadius: 12))
            
            favoriteButton
        }
    }
    
    var favoriteButton: some View {
        Button {
            // Handle button action
        } label: {
            Image(systemName: .heart)
                .foregroundColor(.redUniversal)
                .frame(width: 40, height: 40)
        }
    }
    
    var nftInfo: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: .zero) {
                nftDetails
                addToCartButton
            }
        }
    }
    
    var nftDetails: some View {
        VStack(alignment: .leading, spacing: .zero) {
            StarRatingView(rating: nft.rating)
            
            Text(nft.name)
                .font(.bodyBold)
            
            Text("\(nft.price.formatted()) ETH")
                .font(.medium10)
        }
        .lineLimit(2)
    }
    
    var addToCartButton: some View {
        Button {
            // Handle button action
        } label: {
            Image(.addToCart)
                .frame(width: 40, height: 40)
        }
    }
}

#Preview {
    NftCardView(nft: Nft.mockNft)
        .frame(width: 108, height: 172)
}
