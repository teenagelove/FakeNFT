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
final class NftCatalogViewModel {
    var state: NftCatalogState = .loading
    var presentingDialog = false
    
    private let service: NftCollectionsServiceProtocol
    
    init(service: NftCollectionsServiceProtocol) {
        self.service = service
    }
    
    func loadData() async {
        state = .loading
        
        do {
            let collections = try await service.loadCollections()
            state = .success(collections)
        } catch {
            state = .error(error)
        }
    }
    
    func sortByName() {
        guard case var .success(collections) = state else { return }
        collections.sort { $0.name < $1.name}
        state = .success(collections)
    }
    
    func sortByNftCount() {
        guard case var .success(collections) = state else { return }
        collections.sort { $0.nfts.count > $1.nfts.count }
        state = .success(collections)
    }
}
