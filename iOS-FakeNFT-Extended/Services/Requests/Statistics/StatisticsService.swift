import Foundation

protocol StatisticsService {
    func loadUsers(page: Int, size: Int, sortBy: String) async throws -> [Statistics.User]
    func loadToken(id: String) async throws -> Statistics.Token
}

@MainActor
final class StatisticsServiceImpl {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
}

extension StatisticsServiceImpl: StatisticsService {
    func loadUsers(page: Int, size: Int, sortBy: String) async throws -> [Statistics.User] {
        try await networkClient.send(
            request: Statistics.GetUsers(page: page, size: size, sortBy: sortBy)
        )
    }
    func loadToken(id: String) async throws -> Statistics.Token {
        try await networkClient.send(request: Statistics.GetToken(id: id))
    }
}
