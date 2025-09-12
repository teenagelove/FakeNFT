//
//  Collection.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 08.09.2025.
//

import Foundation

struct NftCollection: Decodable, Identifiable {
    let name: String
    let cover: URL
    let nfts: [Nft]
    let description: String
    let author: String
    let id: String
}
