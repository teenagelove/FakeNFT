//
//  NftCollectionService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 12.09.2025.
//

@MainActor
final class NftCollectionsService: NftCollectionsServiceProtocol {
    private let networkClient: NetworkClient
    private let storage: NftCollectionsStorageProtocol

    init(networkClient: NetworkClient, storage: NftCollectionsStorageProtocol) {
        self.networkClient = networkClient
        self.storage = storage
    }

    func loadCollections() async throws -> [NftCollection] {
        if let collections = await storage.getCollections() {
            return collections
        }

        let request = NftCollectionsRequest()
        let collections: [NftCollection] = try await networkClient.send(request: request)
        await storage.saveCollections(collections)
        return collections
    }

    func loadCollection(id: String) async throws -> NftCollection {
        if let collection = await storage.getCollection(with: id) {
            return collection
        }

        let request = NftCollectionRequest(id: id)
        let collection: NftCollection = try await networkClient.send(request: request)
        await storage.saveCollection(collection)
        return collection
    }
}
