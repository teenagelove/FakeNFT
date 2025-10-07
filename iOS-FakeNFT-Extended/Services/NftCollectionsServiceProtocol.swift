//
//  NftCollectionsServiceProtocol.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 15.09.2025.
//

protocol NftCollectionsServiceProtocol {
    func loadCollections() async throws -> [NftCollection]
    func loadCollection(id: String) async throws -> NftCollection
}
