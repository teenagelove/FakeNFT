import SwiftUI

struct StatisticsView: View {
    @Bindable var viewModel: StatisticsViewModel
    var body: some View {
        List(viewModel.sortedUsers) { user in
            HStack {
                Text(user.rating).font(.caption1)
                HStack {
                    AsyncImage(url: user.avatar) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .foregroundStyle(Color(UIColor(hexString: "#625C5C")))
                    }
                    .frame(width: 28, height: 28)
                    .clipShape(Circle())
                    Text(user.name)
                    Spacer()
                    Text(user.nfts.count.formatted())
                }
                .font(.headline3)
                .padding()
                .frame(height: 80)
                .background(Color(uiColor: .segmentInactive))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 8, trailing: 16))
        }
        .listStyle(.plain)
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
            ForEach(StatisticsViewModel.SortOrder.allCases, id: \.self) { caseName in
                Button(caseName.rawValue) {
                    viewModel.sortOrder = caseName
                }
            }
            Button("Закрыть", role: .cancel) {}
        }
    }
}

#Preview {
    StatisticsView(viewModel: .simpleNetwork)
}
