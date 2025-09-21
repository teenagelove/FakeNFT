import SwiftUI

@MainActor
@Observable
final class StatisticsViewModel {
    enum SortOrder: String, CaseIterable {
        case name = "По имени"
        case rating = "По рейтингу"
    }
    enum State: Equatable {
        case `default`
        case loading
        case loaded
        case error
    }
    var allUsers: [UserViewModel] = []
    var sortOrder: SortOrder = .rating
    var showSortMenu: Bool = false
    var state: State = .default
    var loadUsers: () async throws -> [UserViewModel] = { [] }
}

extension StatisticsViewModel {
    var hasError: Bool {
        get { state == .error }
        set { state = .default }
    }
    func load() async {
        state = .loading
        do {
            allUsers = try await loadUsers()
            state = .loaded
        } catch {
            state = .error
            print(error.localizedDescription)
        }
    }
    var sortedUsers: [UserViewModel] {
        allUsers
            .sorted { (user1, user2) -> Bool in
            switch sortOrder {
            case .name:
                user1.name < user2.name
            case .rating:
                user1.rating > user2.rating
            }
        }
    }
}
