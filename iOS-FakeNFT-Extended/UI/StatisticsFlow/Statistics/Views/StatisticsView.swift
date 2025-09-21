import SwiftUI

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

#Preview {
    StatisticsView(viewModel: .mock)
}
