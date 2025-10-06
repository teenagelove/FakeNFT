//
//  NftPrdersServiceProtocol.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 17.09.2025.
//

protocol NftOrdersServiceProtocol {
    func loadOrders() async throws -> Order
    func updateOrders(for nfts: Set<String>) async throws -> Order
    func orderPayment(currencyId: String) async throws -> OrderPaymentResult
}
