//
//  CatalogNftState.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 15.09.2025.
//

enum BasketOrderState {
    var isFailed: Bool {
        if case .error = self { return true }
        return false
    }
    
    case loading, error(Error), success([Nft])
}
