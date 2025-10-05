//
//  NftCatalogViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 08.09.2025.
//

import Foundation
import Observation
import SwiftUI

@MainActor
@Observable
final class NftCatalogViewModel {
    var state: NftCatalogState = .loading
    var presentingDialog = false
    
    @ObservationIgnored
    @AppStorage("nftCollectionsSortType") private var sortTypeRaw = NftCollectionsSortType.byNftCount.rawValue
    
    private let service: NftCollectionsServiceProtocol
    
    private var sortType: NftCollectionsSortType {
        get { NftCollectionsSortType(rawValue: sortTypeRaw) ?? .byNftCount}
        set { sortTypeRaw = newValue.rawValue }
    }
    
    init(service: NftCollectionsServiceProtocol) {
        self.service = service
    }
    
    func loadData() async {
        state = .loading
        
        do {
            let collections = try await service.loadCollections()
            let filteredCollections = filterDuplicates(collections: collections)
            state = .success(filteredCollections)
            applySort(by: sortType)
        } catch where Task.isCancelled {
            state = .loading
        } catch {
            state = .error(error)
        }
    }
    
    func applySort(by sortType: NftCollectionsSortType) {
        guard case let .success(collections) = state else { return }
        
        if self.sortType != sortType {
            self.sortType = sortType
        }
        
        switch sortType {
        case .byName:
            state = .success(collections.sorted { $0.name < $1.name })
        case .byNftCount:
            state = .success(collections.sorted { $0.nfts.count > $1.nfts.count })
        }
    }
}


// MARK: - Private Methods
private extension NftCatalogViewModel {
    func filterDuplicates(collections: [NftCollection]) -> [NftCollection] {
        collections.map { collection in
            let uniqueNfts = Array(Set(collection.nfts))
            return NftCollection(
                name: collection.name,
                cover: collection.cover,
                nfts: uniqueNfts,
                description: collection.description,
                author: collection.author,
                id: collection.id
            )
        }
    }
}
