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
            VStack(alignment: .leading, spacing: 16) {
                KFImage(nftCollection.cover)
                    .fade(duration: 0.3)
                    .placeholder {
                        Color.gray
                            .frame(maxWidth: .infinity, maxHeight: 140)
                            .clipShape(UnevenRoundedRectangle(
                                topLeadingRadius: 0,
                                bottomLeadingRadius: 12,
                                bottomTrailingRadius: 12,
                                topTrailingRadius: 0
                            ))
                    }
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: 310)
                    .ignoresSafeArea(edges: .top)
                    .clipShape(UnevenRoundedRectangle(
                        topLeadingRadius: 0,
                        bottomLeadingRadius: 12,
                        bottomTrailingRadius: 12,
                        topTrailingRadius: 0
                    ))
            }
        }
    }
}

#Preview {
    NftCollectionView(
        nftCollection: CatalogViewModel.mockData.first!
    )
}
