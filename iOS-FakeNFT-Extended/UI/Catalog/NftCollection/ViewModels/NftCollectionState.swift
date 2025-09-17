//
//  NftCollectionState.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 15.09.2025.
//

// MARK: - NftCollectionState

/// Состояние загрузки коллекции NFT
enum NftCollectionState {
    /// Загрузка завершена успешно, получен массив NFT
    case success([Nft])
    /// Данные в процессе загрузки
    case loading
    /// Произошла ошибка при загрузке
    case error(Error)
}
