//
//  DeleteItemView.swift
//  iOS-FakeNFT-Extended
//
//  Created by 1111 on 17.09.2025.
//

import SwiftUI

struct DeleteItemView: View {
//    @EnvironmentObject var mockData: MockBoughtNft
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
//                    mockData.nfts.removeAll(where: { $0.id == viewModel.idOfBoughtNftToDelete })
                    viewModel.isDeleteItemViewShown = false
                }
                .frame(maxWidth: .infinity, maxHeight: 44)
                .font(.bodyRegular)
                .background(.black)
                .foregroundStyle(.red)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.trailing, 8)
                .padding(.leading, 56)
                Button("Return") {
                    viewModel.isDeleteItemViewShown = false
                }
                .frame(maxWidth: .infinity, maxHeight: 44)
                .font(.bodyRegular)
                .background(.black)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.trailing, 57)
            }
            .padding(.top, 20)
        }
    }
}

//#Preview {
//    DeleteItemView(viewModel: BasketViewModel())
//}
