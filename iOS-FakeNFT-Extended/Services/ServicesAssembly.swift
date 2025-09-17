import Foundation

@Observable
@MainActor
final class ServicesAssembly {

    private let networkClient: NetworkClient
    private let nftStorage: NftStorage
    private let nftCollectionsStorage: NftCollectionsStorageProtocol

    init(
        networkClient: NetworkClient,
        nftStorage: NftStorage,
        nftCollectionsStorage: NftCollectionsStorageProtocol
    ) {
        self.networkClient = networkClient
        self.nftStorage = nftStorage
        self.nftCollectionsStorage = nftCollectionsStorage
    }

    var nftService: NftServiceProtocol {
        NftService(
            networkClient: networkClient,
            storage: nftStorage
        )
    }
    
    var nftCollectionsService: NftCollectionsServiceProtocol {
        NftCollectionsService(
            networkClient: networkClient,
            storage: nftCollectionsStorage
        )
    }
}


extension ServicesAssembly {
    static var preview: ServicesAssembly {
        ServicesAssembly(
            networkClient: DefaultNetworkClient(),
            nftStorage: NftStorageImpl(),
            nftCollectionsStorage: NftCollectionsStorage()
        )
    }
}
