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
    var idOfOrder: String = ""
    
    private let services: ServicesAssembly
    
    init(services: ServicesAssembly) {
        self.services = services
    }
    
    func loadData() async {
        state = .loading
        
        do {
            let order = try await services.nftOrdersService.loadOrders()
            let nfts = try await services.nftService.loadNfts(ids: Array(order.nfts))
            state = .success(nfts)
            
            idOfOrder = order.id
            orderedNfts = nfts
        } catch {
            state = .error(error)
        }
    }
    
    func updateOrders(nfts: [Nft]) async {
        state = .loading
         
        var idsOfNft: [String] = []
        
        nfts.forEach { nft in
            idsOfNft.append(nft.id)
        }
        
        do {
            let updateOrder = try await services.nftOrdersService.updateOrders(for: Set(idsOfNft))
            let nfts = try await services.nftService.loadNfts(ids: Array(updateOrder.nfts))
            state = .success(nfts)
            isDeleteItemViewShown = false
        } catch {
            state = .error(error)
        }
    }
}
