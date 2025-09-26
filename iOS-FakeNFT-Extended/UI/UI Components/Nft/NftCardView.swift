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
    var toggleLike: (() -> Void)? = nil
    var toggleOrder: (() -> Void)? = nil
    
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
        Button { toggleLike?() } label: {
            Image(systemName: .heart)
                .foregroundColor(nft.isLiked ? .redUniversal : .white)
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
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .frame(minHeight: 44, alignment: .center)
            
            Text("\(nft.price.formatted()) ETH")
                .font(.medium10)
        }
        .lineLimit(2)
    }
    
    var addToCartButton: some View {
        Button { toggleOrder?() } label: {
            Image(nft.isOrdered ? .deleteFromCart : .addToCart)
                .frame(width: 40, height: 40)
        }
    }
}

#Preview {
    NftCardView(nft: Nft.mockNft)
        .frame(width: 108, height: 172)
}
