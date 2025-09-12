import SwiftUI

struct CatalogView: View {
    @State var viewModel: CatalogViewModel
    @State private var presentingDialog = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(viewModel.collections) { collection in
                        NftCollectionRowView(collection: collection)
                            .padding(.top, 20)
                            .padding(.horizontal, 16)
                    }
                }
            }
            .overlay {
                if viewModel.isLoading {
                    CustomProgressView()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    SortButton {
                        showDialog()
                    }
                }
            }
        }
        .task {
            await viewModel.loadData()
        }
        .confirmationDialog(
            "Sort.title",
            isPresented: $presentingDialog,
            titleVisibility: .visible
        ) {
            Button("Sort.byName") { viewModel.sortByName() }
            
            Button("Sort.byNftCount") { viewModel.sortByNftCount() }
            
            Button("Close", role: .cancel) {}
        }
        .alert("Error.network", isPresented: $viewModel.isFailed) {
            Button("Cancel", role: .cancel) {}
            
            Button("Error.repeat") {
                Task {
                    await viewModel.loadData()
                }
            }
        }
    }
    
    private func showDialog() {
        presentingDialog = true
    }
}

#Preview {
    CatalogView(
        viewModel: CatalogViewModel(
            service: ServicesAssembly(
                networkClient: DefaultNetworkClient(),
                nftStorage: NftStorageImpl(),
                nftCollectionsStorage: NftCollectionsStorageImpl()
            ).nftCollectionsService
        )
    )
}
