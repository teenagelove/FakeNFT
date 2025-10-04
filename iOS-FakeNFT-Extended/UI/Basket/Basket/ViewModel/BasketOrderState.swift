//
//  CatalogNftState.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 15.09.2025.
//

enum BasketOrderState {
    case loading, error(Error), success([Nft])
}
