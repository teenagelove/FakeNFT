//
//  BasketView.swift
//  iOS-FakeNFT-Extended
//
//  Created by 1111 on 16.09.2025.
//

import SwiftUI

struct BasketView: View {
    @Environment(ServicesAssembly.self) var servicesAssembly
    @State private var viewModel: BasketViewModel
    
    private var basketSum: String {
        var basketSum: Double = 0
        viewModel.orderedNfts.forEach { item in
            basketSum += item.price
        }
        
        return String(basketSum).replacingOccurrences(of: ".", with: ",")
    }
    
    init(services: ServicesAssembly) {
        self._viewModel = State(initialValue: BasketViewModel(services: services))
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                if case .success(let nfts) = viewModel.state {
                    emptyBasketBack
                    VStack(spacing: .zero) {
                        filterButton
                        List(nfts, id: \.id) { boughtNft in
                            BoughtNft(
                                viewModel: viewModel,
                                boughtNftModel: boughtNft
                            )
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets())
                        }.listStyle(.plain)
                        Spacer()
                        lowerBasketPart
                    }
                    .frame(maxWidth: .infinity)
                    .opacity(viewModel.orderedNfts.isEmpty ? 0 : 1)
                    .blur(radius: viewModel.isDeleteItemViewShown ? 40 : 0)
                    .disabled(viewModel.isDeleteItemViewShown)
                }
                if viewModel.isDeleteItemViewShown {
                    DeleteItemView(viewModel: viewModel).toolbar(viewModel.isDeleteItemViewShown ? .hidden : .visible, for: .tabBar)
                }
            }
            .overlay(stateOverlay)
            .animation(.spring(response: 0.4), value: viewModel.isDeleteItemViewShown)
        }
        .tint(.black)
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

private extension BasketView {
    private var lowerBasketPart: some View {
        ZStack {
            background
            lowerBasketWindow
        }
    }
    
    private var emptyBasketBack: some View {
        Text("EmptyBasket")
            .font(.system(size: 17, weight: .bold))
            .opacity(viewModel.orderedNfts.isEmpty ? 1 : 0)
    }
    
    private var filterButton: some View {
        HStack(spacing: .zero) {
            Spacer()
            Button { viewModel.presentingDialog = true } label: {
                Image(.sortIcon)
            }
            .frame(width: 42, height: 42)
            .padding(.trailing, 9)
            .padding(.top, 2)
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 20)
    }
    
    private var listOfBoughtNfts: some View {
        List(viewModel.orderedNfts, id: \.id) { boughtNft in
            BoughtNft(
                viewModel: viewModel,
                boughtNftModel: boughtNft
            )
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets())
        }.listStyle(.plain)
    }
    
    private var background: some View {
        UnevenRoundedRectangle(topLeadingRadius: 12, topTrailingRadius: 12)
            .foregroundStyle(.lightGrey)
            .frame(maxWidth: .infinity, maxHeight: 76)
    }
    
    private var lowerBasketWindow: some View {
        HStack(spacing: .zero) {
            VStack(alignment: .leading, spacing: .zero) {
                Text(String(viewModel.orderedNfts.count) + " NFT").font(.caption1)
                Text(String(basketSum) + " ETH")
                    .foregroundStyle(.green)
                    .font(.bodyBold)
            }.padding(.leading, 16)
            NavigationLink("For.payment") {
                CurrencyChooseView(
                    services: servicesAssembly,
                    basketViewModel: viewModel
                ).toolbar(.hidden, for: .tabBar)
            }
            .frame(maxWidth: .infinity, maxHeight: 44)
            .font(.bodyBold)
            .background(.black)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.trailing, 16)
            .padding(.leading, 24)
        }
    }
    
    private var buttonToPay: some View {
        NavigationLink("For.payment") {
            CurrencyChooseView(
                services: servicesAssembly,
                basketViewModel: viewModel
            ).toolbar(.hidden, for: .tabBar)
        }
        .frame(maxWidth: .infinity, maxHeight: 44)
        .font(.bodyBold)
        .background(.black)
        .foregroundStyle(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.trailing, 16)
        .padding(.leading, 24)
    }
    
    @ViewBuilder
    private var stateOverlay: some View {
        if case .loading = viewModel.state {
            CustomProgressView()
        }
    }
    
    @ViewBuilder
    private var errorButtons: some View {
        Button("Cancel", role: .cancel) {}
        Button("Error.repeat") {
            Task { await viewModel.loadData() }
        }
    }
    
    @ViewBuilder
    private var sortButtons: some View {
        Button("Sort.byPrice") { viewModel.applySort(by: .byPrice) }
        Button("Sort.byRating") { viewModel.applySort(by: .byRating) }
        Button("Sort.byName") { viewModel.applySort(by: .byName) }
        Button("Close", role: .cancel) {}
    }
}

#Preview {
    BasketView(
        services: ServicesAssembly(networkClient: DefaultNetworkClient(),
        nftStorage: NftStorageImpl())
    )
}

