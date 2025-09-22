import Kingfisher
import SwiftUI

private enum Constant {
    static let avatarSize: CGFloat = 28
    static let grayUniversal: Color = .init(UIColor(hexString: "#625C5C"))
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
                        print("last user", user.name, "index", user.index)
                    }
                }
                .background {
                    NavigationLink("") {
                        Text(user.name)
                    }
                }
        }
        .listStyle(.plain)
        .onAppear { viewModel.load(assembly: servicesAssembly) }
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
            Button("Повторить") { Task { viewModel.load(assembly: servicesAssembly) } }
        }
        .confirmationDialog(
            "Сортировка",
            isPresented: $viewModel.showSortMenu,
            titleVisibility: .visible
        ) {
            ForEach(StatisticsViewModel.SortOrder.allCases, id: \.self) { caseName in
                Button(caseName.title) {
                    viewModel.sortOrder = caseName
                    viewModel.load(assembly: servicesAssembly)
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
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .foregroundStyle(Constant.grayUniversal)
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
