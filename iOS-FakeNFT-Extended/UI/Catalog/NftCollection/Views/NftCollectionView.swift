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
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    // Name
                    HStack(spacing: .zero) {
                        Text(nftCollection.name)
                            .font(.headline3)
                        
                        Spacer()
                    }
                    
                    // Author
                    HStack(spacing: 4) {
                        Text("\("Collection.Author"):")
                            .font(.caption2)
                        
                        Link("Author Name", destination: URL(string: "https://google.com")!)
                            .foregroundColor(.blue)
                        
                        Spacer()
                    }
                    
                    // Description
                    Text(nftCollection.description)
                        .font(.caption2)
                }
                .padding(.horizontal, 16)
            }
        }
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    NftCollectionView(nftCollection: NftCollection.mockData[0])
}
