import Foundation

protocol NftService {
    func loadNft(id: String) async throws -> Nft
    func loadNfts(ids: [String]) async throws -> [Nft]
}

@MainActor
final class NftServiceImpl: NftService {

    private let networkClient: NetworkClient
    private let storage: NftStorage

    init(networkClient: NetworkClient, storage: NftStorage) {
        self.storage = storage
        self.networkClient = networkClient
    }

    func loadNft(id: String) async throws -> Nft {
        if let nft = await storage.getNft(with: id) {
            return nft
        }

        let request = NFTRequest(id: id)
        let nft: Nft = try await networkClient.send(request: request)
        await storage.saveNft(nft)
        return nft
    }
    
    func loadNfts(ids: [String]) async throws -> [Nft] {
        return try await withThrowingTaskGroup(of: Nft.self) { group in
            for id in ids {
                group.addTask {
                    try await self.loadNft(id: id)
                }
            }
            
            var nfts: [Nft] = []
            for try await nft in group {
                nfts.append(nft)
            }
            return nfts
        }
    }
}
