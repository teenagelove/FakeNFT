//
//  NftCollectionViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 15.09.2025.
//

import Observation

@MainActor
@Observable
final class NftCollectionViewModel {
    // MARK: - State
    var state: NftCollectionState = .loading
    
    // MARK: - Dependencies
    private let services: ServicesAssembly
    
    // MARK: - Properties
    private var ordersSet: Set<String> = []
    private var likesSet: Set<String> = []
    
    // MARK: - Init
    init(services: ServicesAssembly) {
        self.services = services
    }
    
    // MARK: - Public
    func loadNfts(for ids: [String]) async {
        state = .loading
        
        do {
            let nfts = try await services.nftService.loadNfts(ids: ids)
            let order = try await services.nftOrdersService.loadOrders()
            let profile = try await services.profileService.loadProfile()
            
            likesSet = Set(profile.likes)
            ordersSet = order.nfts
            
            let result = nfts.map { ordersSet.contains($0.id) ? $0.toggledOrder() : $0 }
            let finalResult = result.map { likesSet.contains($0.id) ? $0.toggledLike() : $0 }
            
            state = .success(finalResult)
        } catch {
            state = .error(error)
        }
    }
    
    func toggleLike(for nft: Nft) {
        guard case .success(var nfts) = state,
              let index = nfts.firstIndex(where: { $0.id == nft.id }) else { return }
        
        if likesSet.contains(nft.id) {
            likesSet.remove(nft.id)
        } else {
            likesSet.insert(nft.id)
        }
        
        Task {
            do {
                let response = try await services.profileService.updateProfile(for: likesSet)
                likesSet = Set(response.likes)
                nfts[index] = nft.toggledLike()
                state = .success(nfts)
            } catch {
                state = .error(error)
            }
        }
    }
    
    func toggleOrder(for nft: Nft) {
        guard case .success(var nfts) = state,
              let index = nfts.firstIndex(where: { $0.id == nft.id }) else { return }
        
        if ordersSet.contains(nft.id) {
            ordersSet.remove(nft.id)
        } else {
            ordersSet.insert(nft.id)
        }
        
        Task {
            do {
                let response = try await services.nftOrdersService.updateOrders(for: ordersSet)
                ordersSet = response.nfts
                nfts[index] = nft.toggledOrder()
                state = .success(nfts)
            } catch {
                state = .error(error)
            }
        }
    }
}
