import SwiftUI
import ProgressHUD

struct CatalogView: View {
    @Environment(ServicesAssembly.self) var servicesAssembly
    //    @State private var presentingNft = false
    @State private var presentingDialog = false
    @State private var viewModel = CatalogViewModel()
    
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
        .confirmationDialog(
            "Sort.title",
            isPresented: $presentingDialog,
            titleVisibility: .visible
        ) {
            Button("Sort.byName") { viewModel.sortByName() }
            
            Button("Sort.byNftCount") { viewModel.sortByNftCount() }
            
            Button("Close", role: .cancel) {}
        }
    }
    
    private func showDialog() {
        presentingDialog = true
    }
}

#Preview {
    CatalogView()
        .environment(ServicesAssembly(networkClient: DefaultNetworkClient(), nftStorage: NftStorageImpl()))
}
