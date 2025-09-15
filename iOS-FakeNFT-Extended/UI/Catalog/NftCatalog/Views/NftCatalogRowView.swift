//
//  NftCollectionCellView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 08.09.2025.
//

import SwiftUI
import Kingfisher

struct NftCatalogRowView: View {
    
    // MARK: - Properties
    
    let collection: NftCollection
    
    // MARK: - Content
    
    var body: some View {
        VStack(spacing: 4) {
            coverImage
            titleText
        }
    }
    
    // MARK: - Private views
    
    private var coverImage: some View {
        KFImage(collection.cover)
            .fade(duration: 0.3)
            .placeholder {
                SkeletonView()
            }
            .resizable()
            .scaledToFill()
            .frame(maxWidth: .infinity, maxHeight: 140)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .clipped()
    }
    
    private var titleText: some View {
        HStack(spacing: .zero) {
            Text("\(collection.name) (\(collection.nfts.count))")
                .font(.bodyBold)
            Spacer()
        }
    }
}

// MARK: - NftCatalogRowView_Preview

#Preview {
    NftCatalogRowView(collection: NftCollection.mockData[0])
}
