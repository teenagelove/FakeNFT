import Foundation
import Observation

@MainActor
@Observable
final class UserCollectionItemViewModel: Identifiable {
    init(tokenId: String) {
        self.tokenId = tokenId
    }

    let tokenId: String
    var image: URL?
    var title: String = ""
    var rating: Int = 0
    var price: Double = 0

    var isFavorite: Bool = false
    var isInCart: Bool = false

    var toggleFavorite: (ServicesAssembly) -> Void = { _ in }
    var toggleInCart: (ServicesAssembly) -> Void = { _ in }
    
}

extension UserCollectionItemViewModel {
    func loadTokenInfo(servicesAssembly: ServicesAssembly) {
        Task {
            do {
                let tokenDTO = try await servicesAssembly.statisticsService.loadToken(
                    id: self.tokenId
                )
                image = tokenDTO.images.compactMap { $0 }.first
                title = tokenDTO.name
                rating = tokenDTO.rating
                price = tokenDTO.price
            } catch {
                print(error)
            }
        }
    }
}
