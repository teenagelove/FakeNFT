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
    
    private let columns = [GridItem(.adaptive(minimum: 108), spacing: 9)]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 28) {
                ForEach(Array(nfts.enumerated()), id: \.offset) { _, nft in
                    NftCardView(nft: nft)
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
