import SwiftUI

@MainActor
@Observable
final class UserInformationViewModel {
    var image: UIImage
    var name: String
    var info: String
    var url: URL
    var itemsCount: Int

    init(
        image: UIImage,
        name: String,
        info: String,
        url: URL,
        itemsCount: Int
    ) {
        self.image = image
        self.name = name
        self.info = info
        self.url = url
        self.itemsCount = itemsCount
    }
}
