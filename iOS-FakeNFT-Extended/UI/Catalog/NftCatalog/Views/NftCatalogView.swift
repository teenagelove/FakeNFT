import SwiftUI

struct NftCatalogView: View {
    @Environment(ServicesAssembly.self) var servicesAssembly
    @State var viewModel: NftCatalogViewModel
    
    init(service: NftCollectionsServiceProtocol) {
        self._viewModel = State(initialValue: NftCatalogViewModel(service: service))
    }
    
    var body: some View {
        NavigationStack {
            content
                .overlay(stateOverlay)
                .toolbar { toolbar }
                .background(.appBackground)
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
                        NavigationLink {
                            NftCollectionView(nftCollection: collection, services: servicesAssembly)
                        } label: {
                            NftCatalogRowView(collection: collection)
                                .tint(.blackDay)
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                        }
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
        Button("Sort.byName") { viewModel.applySort(by: .byName) }
        Button("Sort.byNftCount") { viewModel.applySort(by: .byNftCount) }
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
    NftCatalogView(service: ServicesAssembly.preview.nftCollectionsService)
        .environment(ServicesAssembly.preview)
}
