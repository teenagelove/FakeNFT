import SwiftUI

@MainActor
@Observable
final class UserViewModel: Identifiable {
    var index: Int
    var avatar: URL?
    var info: String?
    var name: String
    var nfts: [UserCollectionItemViewModel]
    var rating: String
    var website: URL

    init(
        index: Int,
        avatar: URL?,
        info: String?,
        name: String,
        nfts: [String],
        rating: String,
        website: URL
    ) {
        self.index = index
        self.avatar = avatar
        self.info = info
        self.name = name
        self.nfts = nfts.map(UserCollectionItemViewModel.init)
        self.rating = rating
        self.website = website
        if nfts.count != Set(nfts).count {
            print(name, "has duplicate NFTs")
        }
    }
}
