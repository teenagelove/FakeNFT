import SwiftUI

@MainActor
@Observable
final class StatisticsViewModel {
    enum SortOrder: String, CaseIterable {
        case name
        case rating
        var title: String {
            switch self {
            case .name: "По имени"
            case .rating: "По рейтингу"
            }
        }
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
}

extension StatisticsViewModel {
    var hasError: Bool {
        get { state == .error }
        set { state = .default }
    }
    func load(assembly: ServicesAssembly) {
        state = .loading
        Task {
            do {
                let usersDTO = try await assembly.statisticsService.loadUsers(
                    page: 0,
                    size: 10000,
                    sortBy: sortOrder.rawValue
                )
                users = map(dto: usersDTO)
                state = .loaded
            } catch {
                state = .error
                print(error)
            }

        }
    }
    func map(dto: [Statistics.User]) -> [UserViewModel] {
        dto.enumerated()
            .map { index, user in
                UserViewModel(
                    index: index,
                    avatar: user.avatar,
                    name: user.name,
                    nfts: user.nfts,
                    rating: user.rating,
                    website: user.website
                )
            }
    }
}
