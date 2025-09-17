//
//  NftCollectionViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 15.09.2025.
//

import Observation

@MainActor
@Observable
final class NftCollectionViewModel {
    // MARK: - State
    var state: NftCollectionState = .loading
    
    // MARK: - Dependencies
    private let service: NftService
    
    // MARK: - Init
    init(service: NftService) {
        self.service = service
    }
    
    // MARK: - Public
    func loadNfts(for ids: [String]) async {
        state = .loading
        await fetchNfts(ids: ids)
    }
}

// MARK: - Private Methods
private extension NftCollectionViewModel {
    func fetchNfts(ids: [String]) async {
        do {
            let nfts = try await service.loadNfts(ids: ids)
            state = .success(nfts)
        } catch {
            state = .error(error)
        }
    }
}
