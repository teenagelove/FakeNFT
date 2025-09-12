//
//  NftCollectionCellView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 08.09.2025.
//
import SwiftUI
import Kingfisher

struct NftCollectionRowView: View {
    let collection: NftCollection
    
    var body: some View {
        VStack(spacing: 4) {
            KFImage(collection.cover)
                .fade(duration: 0.3)
                .placeholder {
                    Color.gray
                        .frame(maxWidth: .infinity, maxHeight: 140)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: 140)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .clipped()
            
            HStack {
                Text("\(collection.name) (\(collection.nfts.count))")
                    .font(.bodyBold)
                Spacer()
            }
        }
    }
}

#Preview {
    NftCollectionRowView(collection: CatalogViewModel.mockData[0])
}
