import SwiftUI

@MainActor
@Observable
final class UserViewModel: Identifiable {
    var avatar: URL
    var description: String?
    var name: String
    var nfts: [String]
    var rating: String
    var website: URL

    init(
        avatar: URL,
        description: String? = nil,
        name: String,
        nfts: [String],
        rating: String,
        website: URL
    ) {
        self.avatar = avatar
        self.description = description
        self.name = name
        self.nfts = nfts
        self.rating = rating
        self.website = website
    }
}
