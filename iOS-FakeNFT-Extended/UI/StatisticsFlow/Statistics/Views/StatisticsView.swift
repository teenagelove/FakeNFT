import Kingfisher
import SwiftUI

private enum Constant {
    static let avatarSize: CGFloat = 28
    static let margin: CGFloat = 16
}

struct StatisticsView: View {
    @Environment(ServicesAssembly.self) var servicesAssembly
    @Bindable var viewModel: StatisticsViewModel
    var body: some View {
        List(viewModel.users) { user in
            UserView(user: user)
                .onAppear {
                    if user.index == viewModel.users.count - 1 {
                        viewModel.loadMore(assembly: servicesAssembly)
                    }
                }
                .background {
                    NavigationLink("") { UserInformationView(viewModel: user) }
                }
        }
        .listStyle(.plain)
        .onAppear { viewModel.loadFirstPage(assembly: servicesAssembly) }
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
            Button("Повторить") { Task { viewModel.loadFirstPage(assembly: servicesAssembly) } }
        }
        .confirmationDialog(
            "Сортировка",
            isPresented: $viewModel.showSortMenu,
            titleVisibility: .visible
        ) {
            ForEach(StatisticsViewModel.SortOrder.allCases, id: \.self) { sortOrder in
                Button(sortOrder.title) {
                    if viewModel.sortOrder != sortOrder {
                        viewModel.sortOrder = sortOrder
                        viewModel.loadFirstPage(assembly: servicesAssembly)
                    }
                }
            }
            Button("Закрыть", role: .cancel) {}
        }
    }
}

private struct UserView: View {
    var user: UserViewModel
    var body: some View {
        HStack {
            Text(user.rating).font(.caption1)
            HStack {
                KFImage
                    .url(user.avatar)
                    .placeholder {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .foregroundStyle(Color(uiColor: .grayUniversal))
                    .frame(width: Constant.avatarSize, height: Constant.avatarSize)
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
        .listRowInsets(
            EdgeInsets(
                top: 0,
                leading: Constant.margin,
                bottom: 8,
                trailing: Constant.margin
            )
        )
    }
}

#Preview {
    NavigationStack {
        StatisticsView(viewModel: StatisticsViewModel())
            .environment(ServicesAssembly())
    }
}
