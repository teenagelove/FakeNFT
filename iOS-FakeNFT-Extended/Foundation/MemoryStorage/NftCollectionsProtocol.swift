//
//  NftCollectionsProtocol.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 15.09.2025.
//

protocol NftCollectionsStorageProtocol: AnyObject {
    func saveCollections(_ collections: [NftCollection]) async
    func saveCollection(_ collection: NftCollection) async
    func getCollections() async -> [NftCollection]?
    func getCollection(with id: String) async -> NftCollection?
}
