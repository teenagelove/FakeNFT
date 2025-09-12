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
    var collections: [NftCollection] = []
    
    private let service: NftCollectionsService
    
    init(service: NftCollectionsService) {
        self.service = service
    }
    
    func loadData() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            collections = try await service.loadCollections()
        } catch {
            collections = CatalogViewModel.mockData
        }
    }
    
    func sortByName() {
        collections.sort { $0.name < $1.name}
    }
    
    func sortByNftCount() {
        collections.sort { $0.nftIds.count > $1.nftIds.count }
    }
}


extension CatalogViewModel {
    static let mockData: [NftCollection] = [
        NftCollection(
            name: "Peach",
            cover: URL(string: "https://picsum.photos/200/300?random=1")!,
            nftIds: ["1", "2"],
            description: "Коллекция розовых персонажей",
            author: "Alice",
            id: UUID().uuidString
        ),
        NftCollection(
            name: "Blue",
            cover: URL(string: "https://picsum.photos/200/300?random=2")!,
            nftIds: ["21", "22", "23", "24"],
            description: "Голубая коллекция NFT",
            author: "Bob",
            id: UUID().uuidString
        ),
        NftCollection(
            name: "Brown",
            cover: URL(string: "https://picsum.photos/200/300?random=3")!,
            nftIds: ["31", "32", "33"],
            description: "Коричневая коллекция NFT",
            author: "Charlie",
            id: UUID().uuidString
        ),
        NftCollection(
            name: "Green",
            cover: URL(string: "https://picsum.photos/200/300?random=4")!,
            nftIds: ["41", "42", "43", "44", "45"],
            description: "Зелёная коллекция NFT",
            author: "Diana",
            id: UUID().uuidString
        ),
        NftCollection(
            name: "Purple",
            cover: URL(string: "https://picsum.photos/200/300?random=5")!,
            nftIds: ["51", "52", "53", "54"],
            description: "Фиолетовая коллекция NFT",
            author: "Eve",
            id: UUID().uuidString
        )
    ]
}
