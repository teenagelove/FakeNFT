//
//  BasketView.swift
//  iOS-FakeNFT-Extended
//
//  Created by 1111 on 16.09.2025.
//

import SwiftUI

struct BasketView: View {
    @Environment(ServicesAssembly.self) var servicesAssembly
    //    @StateObject private var mockData = MockBoughtNft()
    @State private var viewModel: BasketViewModel
    
    init(services: ServicesAssembly) {
        self._viewModel = State(initialValue: BasketViewModel(services: services))
    }
    
    private var basketSum: String {
        var basketSum: Double = 0
        viewModel.orderedNfts.forEach { item in
            basketSum += item.price
        }
        
        return String(basketSum).replacingOccurrences(of: ".", with: ",")
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                if case .success = viewModel.state {
                    emptyBasketBack
                    VStack(spacing: .zero) {
                        filterButton
                        List(viewModel.orderedNfts, id: \.id) { boughtNft in
                            BoughtNft(
                                viewModel: viewModel,
                                boughtNftModel: boughtNft
                            )
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets())
                        }.listStyle(.plain)
                        Spacer()
                        ZStack {
                            background
                            lowerBasketWindow
                        }
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
    }
}

private extension BasketView {
    
    var emptyBasketBack: some View {
        Text("EmptyBasket")
            .font(.system(size: 17, weight: .bold))
            .opacity(viewModel.orderedNfts.isEmpty ? 1 : 0)
    }
    
    var filterButton: some View {
        HStack(spacing: .zero) {
            Spacer()
            Button {} label: {
                Image(.sortIcon)
            }
            .frame(width: 42, height: 42)
            .padding(.trailing, 9)
            .padding(.top, 2)
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 20)
    }
    
    var listOfBoughtNfts: some View {
        List(viewModel.orderedNfts, id: \.id) { boughtNft in
            BoughtNft(
                viewModel: viewModel,
                boughtNftModel: boughtNft
            )
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets())
        }.listStyle(.plain)
    }
    
    var background: some View {
        UnevenRoundedRectangle(topLeadingRadius: 12, topTrailingRadius: 12)
            .foregroundStyle(.lightGrey)
            .frame(maxWidth: .infinity, maxHeight: 76)
    }
    
    var lowerBasketWindow: some View {
        HStack(spacing: .zero) {
            VStack(alignment: .leading, spacing: .zero) {
                Text(String(viewModel.orderedNfts.count) + " NFT").font(.caption1)
                Text(String(basketSum) + " ETH")
                    .foregroundStyle(.green)
                    .font(.bodyBold)
            }.padding(.leading, 16)
            NavigationLink("For.payment") {
                CurrencyChooseView().toolbar(.hidden, for: .tabBar)
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
    
    var buttonToPay: some View {
        NavigationLink("For.payment") {
            CurrencyChooseView().toolbar(.hidden, for: .tabBar)
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
}

//#Preview {
//    BasketView()
//}

