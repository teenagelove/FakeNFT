#if DEBUG

    import Foundation

    extension URL {
        fileprivate static let fake = URL(string: "https://example.com")!
    }

    @MainActor
    final class StatisticsServiceMock {

        private let networkClient: NetworkClient

        init(networkClient: NetworkClient) {
            self.networkClient = networkClient
        }
    }

    extension StatisticsServiceMock: StatisticsService {
        func loadUsers(page: Int, size: Int, sortBy: String) async throws -> [User] {
            try await Task.sleep(for: .seconds(2))
            let users =
                sortBy == "name"
                ? Self.mockUsers.sorted(by: { $0.name < $1.name })
                : Self.mockUsers
            let lowerBound = size * page
            guard lowerBound < users.count else { return [] }
            let upperBound = min(size * (page + 1), users.count)
            return Array(users[lowerBound..<upperBound])
        }
        func loadToken(id: String) async throws -> Token {
            .init(
                id: "",
                name: "Test",
                images: [],
                rating: 3,
                price: 22.22
            )
        }
    }

    extension StatisticsServiceMock {
        static let mockUsers: [User] = [
            .init(
                id: "0",
                avatar: .fake,
                description: nil,
                name: "Alex",
                nfts: Array(repeating: "", count: 112),
                rating: "1",
                website: .fake
            ),
            .init(
                id: "1",
                avatar: .fake,
                description: nil,
                name: "Bill",
                nfts: Array(repeating: "", count: 98),
                rating: "2",
                website: .fake
            ),
            .init(
                id: "2",
                avatar: .fake,
                description: nil,
                name: "Alla",
                nfts: Array(repeating: "", count: 72),
                rating: "3",
                website: .fake
            ),
            .init(
                id: "3",
                avatar: .fake,
                description: nil,
                name: "Mads",
                nfts: Array(repeating: "", count: 71),
                rating: "4",
                website: .fake
            ),
            .init(
                id: "4",
                avatar: .fake,
                description: nil,
                name: "Timothée",
                nfts: Array(repeating: "", count: 51),
                rating: "5",
                website: .fake
            ),
            .init(
                id: "5",
                avatar: .fake,
                description: nil,
                name: "Lea",
                nfts: Array(repeating: "", count: 23),
                rating: "6",
                website: .fake
            ),
            .init(
                id: "6",
                avatar: .fake,
                description: nil,
                name: "Eric",
                nfts: Array(repeating: "", count: 11),
                rating: "7",
                website: .fake
            ),
        ]
    }

#endif
