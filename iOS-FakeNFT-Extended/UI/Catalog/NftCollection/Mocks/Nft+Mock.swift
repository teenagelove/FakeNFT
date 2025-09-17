//
//  Nft+Mock.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 15.09.2025.
//

import Foundation

extension Nft {
    static let mockNfts = (1...20).map {nft in
        Nft(
            name: "Angel Alvarado" ,
            rating: 4,
            price: 49.77,
            id: "b3907b86-37c4-4e15-95bc-7f8147a9a660" + "\(nft)",
            images: [URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/White/Lumpy/1.png")!]
        )
    }
    
    static let mockNft = mockNfts[0]
}
