import Foundation

protocol StatisticsService {
    func loadUsers() async throws -> [Statistics.User]
}

@MainActor
final class StatisticsServiceImpl {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
}

extension StatisticsServiceImpl: StatisticsService {
    func loadUsers() async throws -> [Statistics.User] {
        try await networkClient.send(request: Statistics.GetUsers())
    }
}
