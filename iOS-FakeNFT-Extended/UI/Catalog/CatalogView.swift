import SwiftUI

struct CatalogView: View {
    @State var viewModel: CatalogViewModel
    @State private var presentingDialog = false
    
    var body: some View {
        NavigationStack {
            content
                .overlay(viewModel.isLoading ? CustomProgressView() : nil)
                .toolbar { toolbar }
        }
        .task { await viewModel.loadData() }
        .confirmationDialog(
            "Sort.title",
            isPresented: $presentingDialog,
            titleVisibility: .visible,
            actions: { sortButtons }
        )
        .alert("Error.network", isPresented: $viewModel.isFailed) { errorButtons }
    }
}

// MARK: - Private UI components
private extension CatalogView {
    
    var content: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0) {
                ForEach(viewModel.collections) { collection in
                    NftCollectionRowView(collection: collection)
                        .padding(.top, 20)
                        .padding(.horizontal, 16)
                }
            }
        }
    }
    
    var toolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            SortButton { presentingDialog = true }
        }
    }
    
    @ViewBuilder
    var sortButtons: some View {
        Button("Sort.byName") { viewModel.sortByName() }
        Button("Sort.byNftCount") { viewModel.sortByNftCount() }
        Button("Close", role: .cancel) {}
    }
    
    @ViewBuilder
    var errorButtons: some View {
        Button("Cancel", role: .cancel) {}
        Button("Error.repeat") {
            Task { await viewModel.loadData() }
        }
    }
}

#Preview {
    let service = ServicesAssembly(
        networkClient: DefaultNetworkClient(),
        nftStorage: NftStorageImpl(),
        nftCollectionsStorage: NftCollectionsStorageImpl()
    )
    
    let vm = CatalogViewModel(service: service.nftCollectionsService)
    CatalogView(viewModel: vm)
}
