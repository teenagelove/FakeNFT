//
//  NftCollectionState.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 15.09.2025.
//

enum NftCollectionState {
    case loading, error(Error), success([Nft])
}
