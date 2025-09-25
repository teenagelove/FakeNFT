import Foundation

@Observable
@MainActor
final class ServicesAssembly {

    private let networkClient: NetworkClient
    private let nftStorage: NftStorage

    init(
        networkClient: NetworkClient = DefaultNetworkClient(),
        nftStorage: NftStorage = NftStorageImpl()
    ) {
        self.networkClient = networkClient
        self.nftStorage = nftStorage
    }

    var nftService: NftService {
        NftServiceImpl(
            networkClient: networkClient,
            storage: nftStorage
        )
    }
    
    var statisticsService: StatisticsService {
        StatisticsServiceImpl(networkClient: networkClient)
    }
}
