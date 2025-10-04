//
//  NftOrdersService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 17.09.2025.
//

final class NftOrdersService: NftOrdersServiceProtocol {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func loadOrders() async throws -> Order {
        let request = GetNftOrdersRequest()
        return try await networkClient.send(request: request)
    }
    
    func updateOrders(for nfts: Set<String>) async throws -> Order {
        let request = PutNftOrdersRequest(nfts: nfts)
        return try await networkClient.send(request: request)
    }
    
    func orderPayment(currencyId: String) async throws {
        let request = GetOrderPayment(currencyId: currencyId)
        try await networkClient.send(request: request)
    }
}

