import SwiftUI

@MainActor
@Observable
final class UserInformationViewModel {
    var image: URL?
    var name: String
    var info: String
    var website: URL
    var itemsCount: Int

    init(
        avatar: URL?,
        name: String,
        info: String,
        website: URL,
        itemsCount: Int
    ) {
        self.image = avatar
        self.name = name
        self.info = info
        self.website = website
        self.itemsCount = itemsCount
    }
}
