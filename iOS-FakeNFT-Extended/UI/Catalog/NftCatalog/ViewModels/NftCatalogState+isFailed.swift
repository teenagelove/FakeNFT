//
//  NftCatalogState+isFailed.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 15.09.2025.
//

extension NftCatalogState {
    var isFailed: Bool {
        if case .error = self { return true }
        return false
    }
}
