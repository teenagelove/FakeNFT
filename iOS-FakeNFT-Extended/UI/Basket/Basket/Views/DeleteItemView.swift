//
//  DeleteItemView.swift
//  iOS-FakeNFT-Extended
//
//  Created by 1111 on 17.09.2025.
//

import SwiftUI

struct DeleteItemView: View {
    @Bindable var viewModel: BasketViewModel
    
    var body: some View {
        VStack(spacing: .zero) {
            Image(.funnyImageDeleteItem).padding(.bottom, 12)
            Text("DeleteItem")
                .font(.caption2)
                .multilineTextAlignment(.center)
            HStack(spacing: .zero) {
                Button("Delete") {
                    viewModel.orderedNfts.removeAll(where: { $0.id == viewModel.idOfBoughtNftToDelete })
                    Task { await viewModel.updateOrders(nfts: viewModel.orderedNfts) }
                }
                .frame(maxWidth: .infinity, maxHeight: 44)
                .font(.bodyRegular)
                .background(.blackDay)
                .foregroundStyle(.red)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.trailing, 8)
                .padding(.leading, 56)
                Button("Return") {
                    viewModel.isDeleteItemViewShown = false
                }
                .frame(maxWidth: .infinity, maxHeight: 44)
                .font(.bodyRegular)
                .background(.blackDay)
                .foregroundStyle(.whiteDay)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.trailing, 57)
            }
            .padding(.top, 20)
        }
    }
}

#Preview {
    DeleteItemView(viewModel: BasketViewModel(services: ServicesAssembly(
            networkClient: DefaultNetworkClient(),
            nftStorage: NftStorageImpl()
        )))
}
