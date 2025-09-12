import SwiftUI
import ProgressHUD

struct CatalogView: View {
    @Environment(ServicesAssembly.self) var servicesAssembly
    //    @State private var presentingNft = false
    @State private var presentingDialog = false
    @State private var viewModel = CatalogViewModel()
    
    var body: some View {
        //        Button {
        //            showNft()
        //        } label: {
        //            Text(Constants.openNftTitle)
        //                .tint(.blue)
        //        }
        //        .backgroundStyle(.background)
        //        .sheet(isPresented: $presentingNft) {
        //            NftDetailBridgeView()
        //        }
        NavigationStack {
            List(viewModel.collections) { collection in
                NftCollectionRowView(collection: collection)
                    .listRowSeparator(.hidden)
            }
            .padding(.top, 20)
            .listStyle(.plain)
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
    
    //    func showNft() {
    //        presentingNft = true
    //    }
    private func showDialog() {
        presentingDialog = true
    }
}

private enum Constants {
    static let openNftTitle = NSLocalizedString("Catalog.openNft", comment: "")
}


#Preview {
    CatalogView()
        .environment(ServicesAssembly(networkClient: DefaultNetworkClient(), nftStorage: NftStorageImpl()))
}
