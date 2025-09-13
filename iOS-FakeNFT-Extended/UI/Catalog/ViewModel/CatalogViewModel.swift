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
    var isFailed = false
    var collections: [NftCollection] = []
    
    private let service: NftCollectionsService
    
    init(service: NftCollectionsService) {
        self.service = service
    }
    
    func loadData() async {
        isLoading = true
        isFailed = false
        
        defer { isLoading = false }
        
        do {
            collections = try await service.loadCollections()
            isFailed = false
        } catch {
            isFailed = true
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
