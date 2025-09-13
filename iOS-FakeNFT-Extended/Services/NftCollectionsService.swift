//
//  NftCollectionService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 12.09.2025.
//

protocol NftCollectionsService {
    func loadCollections() async throws -> [NftCollection]
    func loadCollection(id: String) async throws -> NftCollection
}

@MainActor
final class NftCollectionsServiceImpl: NftCollectionsService {
    private let networkClient: NetworkClient
    private let storage: NftCollectionsStorage

    init(networkClient: NetworkClient, storage: NftCollectionsStorage) {
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
