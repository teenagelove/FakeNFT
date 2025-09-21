import SwiftUI

@MainActor
@Observable
final class UserViewModel: Identifiable {
    var position: Int
    let id: Int
    let image: UIImage
    let name: String
    let itemCount: Int

    init(
        id: Int,
        position: Int,
        image: UIImage,
        name: String,
        itemCount: Int
    ) {
        self.id = id
        self.position = position
        self.image = image
        self.name = name
        self.itemCount = itemCount
    }
}
