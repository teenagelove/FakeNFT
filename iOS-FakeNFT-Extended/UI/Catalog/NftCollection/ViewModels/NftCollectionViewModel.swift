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
    var state: NftCollectionState = .loading
    
    private let service: NftService
    
    init(
        service: NftService
    ) {
        self.service = service
    }
    
    func loadNfts(for ids: [String]) async {
        state = .loading
        
        do {
            let nfts = try await service.loadNfts(ids: ids)
            state = .success(nfts)
        } catch {
            state = .error(error)
        }
    }
}
