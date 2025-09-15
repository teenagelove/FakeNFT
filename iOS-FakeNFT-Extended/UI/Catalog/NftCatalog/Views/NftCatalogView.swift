import SwiftUI

struct NftCatalogView: View {
    @State var viewModel: NftCatalogViewModel
    
    var body: some View {
        NavigationStack {
            content
                .overlay(stateOverlay)
                .toolbar { toolbar }
        }
        .task { await viewModel.loadData() }
        .confirmationDialog(
            "Sort.title",
            isPresented: $viewModel.presentingDialog,
            titleVisibility: .visible,
            actions: { sortButtons }
        )
        .alert("Error.network", isPresented: .constant(viewModel.state.isFailed)) { errorButtons }
    }
}

// MARK: - Private UI components
private extension NftCatalogView {
    
    var content: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0) {
                if case let .success(collections) = viewModel.state {
                    ForEach(collections) { collection in
                        NftCatalogRowView(collection: collection)
                            .padding(.top, 20)
                            .padding(.horizontal, 16)
                    }
                }
            }
        }
    }
    
    var toolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            SortButton { viewModel.presentingDialog = true }
        }
    }
    
    @ViewBuilder
    var sortButtons: some View {
        Button("Sort.byName") { viewModel.sortByName() }
        Button("Sort.byNftCount") { viewModel.sortByNftCount() }
        Button("Close", role: .cancel) {}
    }
    
    @ViewBuilder
    private var stateOverlay: some View {
        if case .loading = viewModel.state {
            CustomProgressView()
        }
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
        nftCollectionsStorage: NftCollectionsStorage()
    )
    
    let vm = NftCatalogViewModel(service: service.nftCollectionsService)
    NftCatalogView(viewModel: vm)
}
