import SwiftUI

@Observable
final class UserViewModel: Identifiable {
    var id: Int
    var position: Int
    var image: UIImage
    var name: String
    var itemCount: Int

    init(
        id: Int,
        position: Int,
        image: UIImage,
        name: String,
        itemCount: Int
    ) {
        self.id = id
        self.position = position
        self.image = image
        self.name = name
        self.itemCount = itemCount
    }
}

@Observable
final class StatisticsViewModel {
    enum SortOrder: String, CaseIterable, Identifiable {
        var id: String { rawValue }
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
}

extension StatisticsViewModel {
    var hasError: Bool {
        get { state == .error }
        set { state = .default }
    }
    func load() async {
        state = .loading
        do {
            try await Task.sleep(for: .seconds(1))
            allUsers = mockUsers
            state = .loaded
        } catch {
            state = .error
            print(error.localizedDescription)
        }
    }
    var sortedUsers: [UserViewModel] {
        let sorted = allUsers.sorted { (user1, user2) -> Bool in
            switch sortOrder {
            case .name:
                user1.name < user2.name
            case .rating:
                user1.itemCount > user2.itemCount
            }
        }
        for (index, user) in sorted.enumerated() {
            user.position = index + 1
        }
        return Array(sorted)
    }
}

struct StatisticsView: View {
    @Bindable var viewModel: StatisticsViewModel
    var body: some View {
        List(viewModel.sortedUsers) { user in
            HStack {
                Text(user.position.formatted()).font(.caption1)
                HStack {
                    Image(uiImage: user.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 28, height: 28)
                        .clipShape(Circle())
                    Text(user.name)
                    Spacer()
                    Text(user.itemCount.formatted())
                }
                .font(.headline3)
                .padding()
                .frame(height: 80)
                .background(Color(uiColor: .segmentInactive))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .listRowSpacing(-15)
        .task { await viewModel.load() }
        .overlay {
            if viewModel.state == .loading {
                ProgressView()
            }
        }
        .alert(
            "Не удалось получить данные",
            isPresented: $viewModel.hasError
        ) {
            Button("Отмена") { viewModel.state = .loaded }
            Button("Повторить") { Task { await viewModel.load() } }
        }
        .confirmationDialog(
            "Сортировка",
            isPresented: $viewModel.showSortMenu,
            titleVisibility: .visible
        ) {
            ForEach(StatisticsViewModel.SortOrder.allCases) { caseName in
                Button(caseName.rawValue) {
                    viewModel.sortOrder = caseName
                }
            }
            Button("Закрыть", role: .cancel) {}
        }
    }
}

struct StatisticsTabView: View {
    let viewModel = StatisticsViewModel()
    var body: some View {
        NavigationStack {
            StatisticsView(viewModel: viewModel)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            viewModel.showSortMenu = true
                        } label: {
                            Image(uiImage: .sortIcon)
                        }
                        .tint(.blackDay)
                    }
                }
        }
    }
}

#Preview {
    StatisticsTabView()
}

#if DEBUG
private let mockUsers: [UserViewModel] = [
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
#endif
