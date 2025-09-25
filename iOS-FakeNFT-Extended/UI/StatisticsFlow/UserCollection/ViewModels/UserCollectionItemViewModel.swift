import UIKit

@MainActor
@Observable
final class UserCollectionItemViewModel: Identifiable {
    init(token_id: String) {
        self.token_id = token_id
    }

    let token_id: String
    var image: URL?
    var title: String = ""
    var rating: Int = 0
    var price: Double = 0

    // TODO: connect to services
    var isFavorite: Bool = false
    var isInCart: Bool = false

}

extension UserCollectionItemViewModel {
    func toggleFavorite() {
        print(#function)
        isFavorite.toggle()
    }
    func toggleInCart() {
        print(#function)
        isInCart.toggle()
    }
    func loadTokenInfo(servicesAssembly: ServicesAssembly) {
        Task {
            do {
                let tokenDTO = try await servicesAssembly.statisticsService.loadToken(
                    id: self.token_id
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
