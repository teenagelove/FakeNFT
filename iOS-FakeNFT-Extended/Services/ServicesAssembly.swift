import Foundation

@Observable
@MainActor
final class ServicesAssembly {

    private let networkClient: NetworkClient
    private let nftStorage: NftStorage

    init(
        networkClient: NetworkClient,
        nftStorage: NftStorage
    ) {
        self.networkClient = networkClient
        self.nftStorage = nftStorage
    }

    var nftService: NftService {
        NftService(
            networkClient: networkClient,
            storage: nftStorage
        )
    }
    
    var nftOrdersService: NftOrdersServiceProtocol {
        NftOrdersService(networkClient: networkClient)
    }
    
    var currencyService: CurrencyServiceProtocol {
        CurrencyService(networkClient: networkClient)
    }
}
