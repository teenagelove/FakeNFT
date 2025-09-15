//
//  NftCollection+Mock.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 15.09.2025.
//

import Foundation

extension NftCollection {
    static let mockData: [NftCollection] = [
        NftCollection(
            name: "Peach",
            cover: URL(string: "https://picsum.photos/200/300?random=1")!,
            nfts: ["1", "2"],
            description: "Коллекция розовых персонажей",
            author: "Alice",
            id: UUID().uuidString
        ),
        NftCollection(
            name: "Blue",
            cover: URL(string: "https://picsum.photos/200/300?random=2")!,
            nfts: ["21", "22", "23", "24"],
            description: "Голубая коллекция NFT",
            author: "Bob",
            id: UUID().uuidString
        ),
        NftCollection(
            name: "Brown",
            cover: URL(string: "https://picsum.photos/200/300?random=3")!,
            nfts: ["31", "32", "33"],
            description: "Коричневая коллекция NFT",
            author: "Charlie",
            id: UUID().uuidString
        ),
        NftCollection(
            name: "Green",
            cover: URL(string: "https://picsum.photos/200/300?random=4")!,
            nfts: ["41", "42", "43", "44", "45"],
            description: "Зелёная коллекция NFT",
            author: "Diana",
            id: UUID().uuidString
        ),
        NftCollection(
            name: "Purple",
            cover: URL(string: "https://picsum.photos/200/300?random=5")!,
            nfts: ["51", "52", "53", "54"],
            description: "Фиолетовая коллекция NFT",
            author: "Eve",
            id: UUID().uuidString
        )
    ]
}
