//
//  CurrencyService.swift
//  iOS-FakeNFT-Extended
//
//  Created by 1111 on 04.10.2025.
//

import Foundation

final class CurrencyService:CurrencyServiceProtocol {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func loadCurrencies() async throws -> [Currency] {
        let request = GetCurrencies()
        return try await networkClient.send(request: request)
    }
}
