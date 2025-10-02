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
    enum Constant {
        static let pageSize: Int = 25
    }
    var users: [UserViewModel] = []
    var showSortMenu: Bool = false
    var state: State = .default
    var currentPage: Int = 0
    var hasGotAllUsers: Bool = false

    @ObservationIgnored
    @AppStorage("StatisticsViewModel.sortOrder")
    var sortOrder: SortOrder = .rating
}

extension StatisticsViewModel {
    var hasError: Bool {
        get { state == .error }
        set { state = .default }
    }
    func loadFirstPage(assembly: ServicesAssembly) {
        currentPage = 0
        hasGotAllUsers = false
        users = []
        load(assembly: assembly)
    }
    func loadMore(assembly: ServicesAssembly) {
        guard !hasGotAllUsers else { return }
        load(assembly: assembly)
    }
    func load(assembly: ServicesAssembly) {
        state = .loading
        Task {
            do {
                let usersDTO = try await assembly.statisticsService.loadUsers(
                    page: currentPage,
                    size: Constant.pageSize,
                    sortBy: sortOrder.rawValue
                )
                if usersDTO.isEmpty {
                    hasGotAllUsers = true
                } else {
                    users += map(dto: usersDTO)
                    currentPage += 1
                    print(
                        "loading:",
                        "got users:", usersDTO.count,
                        "have users:", users.count,
                        "currentPage:", currentPage,
                    )
                }
                state = .loaded
            } catch {
                state = .error
                print(error)
            }
        }

    }

    func map(dto: [Statistics.User]) -> [UserViewModel] {
        let firstIndex = users.count
        return dto.enumerated()
            .map { index, user in
                UserViewModel(
                    index: index + firstIndex,
                    avatar: user.avatar,
                    info: user.description,
                    name: user.name,
                    userCollectionViewModel: .init(
                        items: user.nfts.map(UserCollectionItemViewModel.init)
                    ),
                    rating: user.rating,
                    website: user.website
                )
            }
    }
}
