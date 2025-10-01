import SwiftUI
import ProgressHUD

struct UserCollectionView: View {
    var viewModel: UserCollectionViewModel
    
    @Environment(ServicesAssembly.self) var servicesAssembly
    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                ],
                spacing: 28
            ) {
                ForEach(viewModel.items) { item in
                    UserCollectionItemView(viewModel: item)
                }
            }
        }
        .padding(.horizontal)
        .onAppear { viewModel.update(serviceAssembly: servicesAssembly) }
    }
}

#Preview {
    UserCollectionView(
        viewModel:
            .init(
                items: [
                    "1fda6f0c-a615-4a1a-aa9c-a1cbd7cc76ae",
                    "77c9aa30-f07a-4bed-886b-dd41051fade2",
                    "b3907b86-37c4-4e15-95bc-7f8147a9a660",
                    "a06d0075-d1a7-40dc-b710-db6808c28cca",
                    "f380f245-0264-4b42-8e7e-c4486e237504",
                ].map(UserCollectionItemViewModel.init)
            )
    )
    .environment(ServicesAssembly())
}
