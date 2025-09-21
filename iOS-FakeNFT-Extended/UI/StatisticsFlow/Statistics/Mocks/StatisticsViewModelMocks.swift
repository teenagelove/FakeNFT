#if DEBUG

import Foundation

private extension URL {
    static let fake = URL(string: "https://example.com")!
}

extension StatisticsViewModel {
    static var simpleNetwork: Self {
        let viewModel = Self()
        viewModel.loadUsers = {
            let networkClient = DefaultNetworkClient()
            do {
                let users: [Statistics.User] = try await networkClient.send(
                    request: Statistics.GetUsers(page: 0, size: 20, sortBy: "rating")
                )
                return users.enumerated().map { index, user in
                    UserViewModel(
                        index: index,
                        avatar: user.avatar,
                        name: user.name,
                        nfts: user.nfts,
                        rating: user.rating,
                        website: user.website
                    )
                }
            } catch {
                print(error)
                throw error
            }
        }
        return viewModel

    }
    static var mock: Self {
        let viewModel = Self()
        viewModel.loadUsers = {
            try await Task.sleep(for: .seconds(1))
            return mockUsers
        }
        return viewModel
    }
    
    static let mockUsers: [UserViewModel] = [
        .init(
            index: 0,
            avatar: .fake,
            name: "Alex",
            nfts: Array(repeating: "", count: 112),
            rating: "1",
            website: .fake
        ),
        .init(
            index: 1,
            avatar: .fake,
            name: "Bill",
            nfts: Array(repeating: "", count: 98),
            rating: "2",
            website: .fake
        ),
        .init(
            index: 2,
            avatar: .fake,
            name: "Alla",
            nfts: Array(repeating: "", count: 72),
            rating: "3",
            website: .fake
        ),
        .init(
            index: 3,
            avatar: .fake,
            name: "Mads",
            nfts: Array(repeating: "", count: 71),
            rating: "4",
            website: .fake
        ),
        .init(
            index: 4,
            avatar: .fake,
            name: "Timothée",
            nfts: Array(repeating: "", count: 51),
            rating: "5",
            website: .fake
        ),
        .init(
            index: 5,
            avatar: .fake,
            name: "Lea",
            nfts: Array(repeating: "", count: 23),
            rating: "6",
            website: .fake
        ),
        .init(
            index: 6,
            avatar: .fake,
            name: "Eric",
            nfts: Array(repeating: "", count: 11),
            rating: "7",
            website: .fake
        ),
    ]
}
#endif
