import UIKit

@MainActor
@Observable
final class UserCollectionItemViewModel: Identifiable {
    init(
        id: Int,
        image: UIImage,
        isFavorite: Bool,
        title: String,
        rating: Int,
        price: Double,
        isInCart: Bool
    ) {
        self.id = id
        self.image = image
        self.isFavorite = isFavorite
        self.title = title
        self.rating = rating
        self.price = price
        self.isInCart = isInCart
    }

    let id: Int
    let image: UIImage
    let title: String
    let rating: Int
    let price: Double
    
    var isFavorite: Bool
    var isInCart: Bool

    func toggleFavorite() {
        print(#function)
        isFavorite.toggle()
    }
    func toggleInCart() {
        print(#function)
        isInCart.toggle()
    }
}
