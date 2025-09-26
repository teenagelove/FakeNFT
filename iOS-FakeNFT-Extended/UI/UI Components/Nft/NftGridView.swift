//
//  NftGridView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 15.09.2025.
//

import SwiftUI

struct NftGridView: View {
    let nfts: [Nft]
    let onSelect: (Nft) -> Void
    var onToggleLike: ((Nft) -> Void)? = nil
    var onToggleOrder: ((Nft) -> Void)? = nil
    
    private let columns = [GridItem(.adaptive(minimum: 108), spacing: 9)]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 28) {
                ForEach(nfts) { nft in
                    NftCardView(
                        nft: nft,
                        toggleLike: { onToggleLike?(nft) },
                        toggleOrder: { onToggleOrder?(nft) }
                    )
                    .onTapGesture {
                        onSelect(nft)
                    }
                }
            }
        }
    }
}

#Preview {
    NftGridView(nfts: Nft.mockNfts) { _ in }
}
