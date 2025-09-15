//
//  NftCollectionView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 12.09.2025.
//

import SwiftUI
import Kingfisher

struct NftCollectionView: View {
    let nftCollection: NftCollection
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                coverImage
                collectionInfo
            }
        }
        .ignoresSafeArea(edges: .top)
    }
}

private extension NftCollectionView {
    
    var coverImage: some View {
        KFImage(nftCollection.cover)
            .fade(duration: 0.3)
            .placeholder { SkeletonView() }
            .resizable()
            .scaledToFill()
            .frame(maxWidth: .infinity, maxHeight: 310)
            .clipShape(
                UnevenRoundedRectangle(
                    topLeadingRadius: 0,
                    bottomLeadingRadius: 12,
                    bottomTrailingRadius: 12,
                    topTrailingRadius: 0
                )
            )
    }
    
    var collectionInfo: some View {
        VStack(spacing: 24) {
            collectionHeader
            NftGridView(nfts: Nft.mockNfts)
        }
        .padding(.horizontal, 16)
    }
    
    var collectionHeader: some View {
        VStack(spacing: 8) {
            collectionName
            authorAndDescription
        }
    }
    
    var collectionName: some View {
        HStack(spacing: .zero) {
            Text(nftCollection.name)
                .font(.headline3)
            Spacer()
        }
    }
    
    var authorAndDescription: some View {
        VStack(alignment: .leading, spacing: .zero) {
            HStack(spacing: 4) {
                Text("Collection.Author:")
                    .font(.caption2)
                Link(nftCollection.author, destination: URL(string: "https://google.com")!)
                    .font(.caption1)
                    .foregroundColor(.blue)
                Spacer()
            }
            
            Text(nftCollection.description)
                .font(.caption2)
        }
    }
}


#Preview {
    NftCollectionView(nftCollection: NftCollection.mockData[0])
}
