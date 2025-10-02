import SwiftUI

@MainActor
@Observable
final class UserViewModel: Identifiable {
    var index: Int
    var avatar: URL?
    var info: String?
    var name: String
    var userCollectionViewModel: UserCollectionViewModel
    var rating: String
    var website: URL

    init(
        index: Int,
        avatar: URL?,
        info: String?,
        name: String,
        userCollectionViewModel: UserCollectionViewModel,
        rating: String,
        website: URL
    ) {
        self.index = index
        self.avatar = avatar
        self.info = info
        self.name = name
        self.userCollectionViewModel = userCollectionViewModel
        self.rating = rating
        self.website = website
    }
}
