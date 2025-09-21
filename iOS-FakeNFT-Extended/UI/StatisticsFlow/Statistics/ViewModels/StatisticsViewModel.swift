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
    var users: [UserViewModel] = []
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
    func load() {
        state = .loading
        Task {
            do {
                users = try await loadUsers()
                state = .loaded
            } catch {
                state = .error
                print(error)
            }

        }
    }
}
