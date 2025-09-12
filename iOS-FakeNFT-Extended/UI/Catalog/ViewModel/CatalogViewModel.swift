//
//  CatalogViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 08.09.2025.
//

import Foundation
import Observation

@MainActor
@Observable
final class CatalogViewModel {
    var isLoading = false
    var collections: [NftCollection]
    
    init() {
        collections = []
        loadData()
    }
    
    func loadData() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.collections = Self.mockData
            self.isLoading = false
        }
    }
    
    func sortByName() {
        collections.sort { $0.name < $1.name}
    }
    
    func sortByNftCount() {
        collections.sort { $0.nfts.count > $1.nfts.count }
    }
}


extension CatalogViewModel {
    static let mockData: [NftCollection] = [
        NftCollection(
            name: "Peach",
            cover: URL(string: "https://picsum.photos/200/300?random=1")!,
            nfts: [
                Nft(id: UUID().uuidString, images: [URL(string: "https://picsum.photos/400/400?random=11")!, URL(string: "https://picsum.photos/400/400?random=12")!]),
                Nft(id: UUID().uuidString, images: [URL(string: "https://picsum.photos/400/400?random=13")!]),
                Nft(id: UUID().uuidString, images: [URL(string: "https://picsum.photos/400/400?random=14")!, URL(string: "https://picsum.photos/400/400?random=15")!])
            ],
            description: "Коллекция розовых персонажей",
            author: "Alice",
            id: UUID().uuidString
        ),
        NftCollection(
            name: "Blue",
            cover: URL(string: "https://picsum.photos/200/300?random=2")!,
            nfts: [
                Nft(id: UUID().uuidString, images: [URL(string: "https://picsum.photos/400/400?random=21")!]),
                Nft(id: UUID().uuidString, images: [URL(string: "https://picsum.photos/400/400?random=22")!, URL(string: "https://picsum.photos/400/400?random=23")!]),
                Nft(id: UUID().uuidString, images: [URL(string: "https://picsum.photos/400/400?random=24")!]),
                Nft(id: UUID().uuidString, images: [URL(string: "https://picsum.photos/400/400?random=25")!, URL(string: "https://picsum.photos/400/400?random=26")!])
            ],
            description: "Голубая коллекция NFT",
            author: "Bob",
            id: UUID().uuidString
        ),
        NftCollection(
            name: "Brown",
            cover: URL(string: "https://picsum.photos/200/300?random=3")!,
            nfts: [
                Nft(id: UUID().uuidString, images: [URL(string: "https://picsum.photos/400/400?random=31")!, URL(string: "https://picsum.photos/400/400?random=32")!]),
                Nft(id: UUID().uuidString, images: [URL(string: "https://picsum.photos/400/400?random=33")!])
            ],
            description: "Коричневая коллекция NFT",
            author: "Charlie",
            id: UUID().uuidString
        ),
        NftCollection(
            name: "Green",
            cover: URL(string: "https://picsum.photos/200/300?random=4")!,
            nfts: [
                Nft(id: UUID().uuidString, images: [URL(string: "https://picsum.photos/400/400?random=41")!]),
                Nft(id: UUID().uuidString, images: [URL(string: "https://picsum.photos/400/400?random=42")!, URL(string: "https://picsum.photos/400/400?random=43")!]),
                Nft(id: UUID().uuidString, images: [URL(string: "https://picsum.photos/400/400?random=44")!]),
                Nft(id: UUID().uuidString, images: [URL(string: "https://picsum.photos/400/400?random=45")!]),
                Nft(id: UUID().uuidString, images: [URL(string: "https://picsum.photos/400/400?random=46")!])
            ],
            description: "Зелёная коллекция NFT",
            author: "Diana",
            id: UUID().uuidString
        ),
        NftCollection(
            name: "Purple",
            cover: URL(string: "https://picsum.photos/200/300?random=5")!,
            nfts: [
                Nft(id: UUID().uuidString, images: [URL(string: "https://picsum.photos/400/400?random=51")!]),
                Nft(id: UUID().uuidString, images: [URL(string: "https://picsum.photos/400/400?random=52")!]),
                Nft(id: UUID().uuidString, images: [URL(string: "https://picsum.photos/400/400?random=53")!]),
                Nft(id: UUID().uuidString, images: [URL(string: "https://picsum.photos/400/400?random=54")!])
            ],
            description: "Фиолетовая коллекция NFT",
            author: "Eve",
            id: UUID().uuidString
        )
    ]
}
