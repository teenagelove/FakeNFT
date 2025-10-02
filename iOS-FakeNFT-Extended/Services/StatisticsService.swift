import Foundation

protocol StatisticsService {
    func loadUsers(page: Int, size: Int, sortBy: String) async throws -> [User]
    func loadToken(id: String) async throws -> Token
}

@MainActor
final class StatisticsServiceImpl {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
}

extension StatisticsServiceImpl: StatisticsService {
    func loadUsers(page: Int, size: Int, sortBy: String) async throws -> [User] {
        try await networkClient.send(
            request: GetUsers(page: page, size: size, sortBy: sortBy)
        )
    }
    func loadToken(id: String) async throws -> Token {
        try await networkClient.send(request: NFTRequest(id: id))
    }
}
