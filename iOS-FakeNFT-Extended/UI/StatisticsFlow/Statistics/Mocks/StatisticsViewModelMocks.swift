#if DEBUG
extension StatisticsViewModel {
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
            id: 0,
            position: 1,
            image: .zeus,
            name: "Alex",
            itemCount: 112
        ),
        .init(
            id: 1,
            position: 2,
            image: .zeus,
            name: "Bill",
            itemCount: 98
        ),
        .init(
            id: 2,
            position: 3,
            image: .zeus,
            name: "Alla",
            itemCount: 72
        ),
        .init(
            id: 3,
            position: 4,
            image: .zeus,
            name: "Mads",
            itemCount: 71
        ),
        .init(
            id: 4,
            position: 5,
            image: .zeus,
            name: "Timothée",
            itemCount: 51
        ),
        .init(
            id: 5,
            position: 6,
            image: .zeus,
            name: "Lea",
            itemCount: 23
        ),
        .init(
            id: 6,
            position: 7,
            image: .zeus,
            name: "Eric",
            itemCount: 11
        ),
    ]
}
#endif
