//
//  BasketViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by 1111 on 23.09.2025.
//

import SwiftUI

@MainActor
@Observable
final class BasketViewModel {
    var isDeleteItemViewShown: Bool = false
    var idOfBoughtNftToDelete: String = ""
    var state: BasketOrderState = .loading
    var orderedNfts: [Nft] = []
    
    @ObservationIgnored
    @AppStorage("BasketNftsSortType") private var sortTypeRaw = BasketNftSortType.byPrice.rawValue
    
    private var idOfOrder: String = ""
    
    private var sortType: BasketNftSortType {
        get { BasketNftSortType(rawValue: sortTypeRaw) ?? .byPrice}
        set { sortTypeRaw = newValue.rawValue }
    }
    
    private let services: ServicesAssembly
    
    init(services: ServicesAssembly) {
        self.services = services
    }
    
    func loadData() async {
        state = .loading
        
        do {
            let order = try await services.nftOrdersService.loadOrders()
            let nfts = try await fetchNfts(for: order.nfts)
            state = .success(nfts)
            
            idOfOrder = order.id
            orderedNfts = nfts
        } catch where Task.isCancelled {
            return
        } catch {
            state = .error(error)
        }
    }
    
    func updateOrders(nfts: [Nft]) async {
        state = .loading
        
        do {
            let updateOrder = try await services.nftOrdersService.updateOrders(for: Set(nfts.map(\.id)))
            let nfts = try await fetchNfts(for: updateOrder.nfts)
            state = .success(nfts)
            isDeleteItemViewShown = false
        } catch {
            state = .error(error)
        }
    }
    
    func applySort(by sortType: BasketNftSortType) {
        guard case let .success(nfts) = state else { return }
        
        if self.sortType != sortType {
            self.sortType = sortType
        }
        
        switch sortType {
        case .byName:
            state = .success(nfts.sorted { $0.name < $1.name } )
        case .byPrice:
            state = .success(nfts.sorted { $0.price < $1.price } )
        case .byRating:
            state = .success(nfts.sorted { $0.rating < $1.rating } )
        }
    }
    
    private func fetchNfts(for ids: Set<String>) async throws -> [Nft] {
        try await services.nftService.loadNfts(ids: Array(ids))
    }
}
