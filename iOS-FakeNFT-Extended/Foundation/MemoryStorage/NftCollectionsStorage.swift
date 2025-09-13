//
//  NftCollectionStorage.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 12.09.2025.
//

import Foundation

protocol NftCollectionsStorage: AnyObject {
    func saveCollections(_ collections: [NftCollection]) async
    func saveCollection(_ collection: NftCollection) async
    func getCollections() async -> [NftCollection]?
    func getCollection(with id: String) async -> NftCollection?
}

actor NftCollectionsStorageImpl: NftCollectionsStorage {
    private var collections: [String: NftCollection] = [:]

    func saveCollections(_ collections: [NftCollection]) async {
        for collection in collections {
            self.collections[collection.id] = collection
        }
    }

    func saveCollection(_ collection: NftCollection) async {
        collections[collection.id] = collection
    }

    func getCollections() async -> [NftCollection]? {
        Array(collections.values).isEmpty ? nil : Array(collections.values)
    }

    func getCollection(with id: String) async -> NftCollection? {
        collections[id]
    }
}
