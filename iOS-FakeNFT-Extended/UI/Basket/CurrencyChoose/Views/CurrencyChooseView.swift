//
//  CurrencyChooseView.swift
//  iOS-FakeNFT-Extended
//
//  Created by 1111 on 17.09.2025.
//

import SwiftUI

struct CurrencyChooseView: View {
    @Environment(\.dismiss) var dismiss
    @State private var currencyChooseViewModel: CurrencyChooseViewModel
    @State private var isWebViewPresented: Bool = false
    @Bindable var basketViewModel: BasketViewModel
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private var currencyId: String {
        let selectedItem = currencyChooseViewModel.savedCurrencies.filter { $0.isSelected == true }
        return selectedItem.isEmpty ? "" : selectedItem[0].id
    }
    
    init(services: ServicesAssembly, basketViewModel: BasketViewModel) {
        self._currencyChooseViewModel = State(initialValue: CurrencyChooseViewModel(services: services))
        self._basketViewModel = Bindable(basketViewModel)
    }
    
    
    var body: some View {
        VStack(spacing: .zero) {
            if case .success = currencyChooseViewModel.stateCurrencyOption {
                LazyVGrid(columns: columns, spacing: 7) {
                    ForEach(currencyChooseViewModel.savedCurrencies, id: \.self) { currency in
                        GridCell(
                            viewModel: currencyChooseViewModel,
                            currency: currency
                        )
                    }
                }
                .padding(.top, 20)
                .padding(.horizontal, 16)
                Spacer()
                ZStack {
                    UnevenRoundedRectangle(topLeadingRadius: 12, topTrailingRadius: 12).foregroundStyle(.lightGrey)
                    VStack(alignment: .leading, spacing: .zero) {
                        VStack(alignment: .leading, spacing: .zero) {
                            Text("UserAgreementPart1").font(.caption2)
                            Text("UserAgreementPart2")
                                .font(.caption2)
                                .foregroundStyle(.blue)
                                .onTapGesture {
                                    isWebViewPresented = true
                                }
                        }.padding([.top, .leading], 16)
                        Spacer()
                        Button("Pay") {
                            Task { await currencyChooseViewModel.payOrder(currencyId: currencyId) }
                        }
                        .frame(maxWidth: .infinity, maxHeight: 60)
                        .font(.bodyBold)
                        .background(.black)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 50, trailing: 12))
                        .disabled(currencyId == "")
                    }
                }
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: 152)
            }
        }
        .toolbarRole(.editor)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("CurrencyChooseToPay").font(.bodyBold)
            }
        }
        .task { await currencyChooseViewModel.loadData() }
        .overlay(stateOverlayCurrencyOption)
        .overlay(stateOverlayOrderPayment)
        .alert("Error.network", isPresented: .constant(currencyChooseViewModel.stateCurrencyOption.isFailed)) { errorButtonsCurrencyOption }
        .alert("Error.orderPayment", isPresented: .constant(currencyChooseViewModel.stateOrderPayment.isFailed)) { errorButtonsOrderPayment }
        .fullScreenCover(isPresented: $currencyChooseViewModel.isSuccessPaymentViewShown) {
            SuccessPaymentView(
                currencyChooseViewModel: currencyChooseViewModel,
                basketViewModel: basketViewModel
            ) { dismiss() }
        }
        .fullScreenCover(isPresented: $isWebViewPresented) {
            WebViewBridge()
        }
    }
}

private extension CurrencyChooseView {
    @ViewBuilder
    private var stateOverlayCurrencyOption: some View {
        if case .loading = currencyChooseViewModel.stateCurrencyOption {
            CustomProgressView()
        }
    }
    
    @ViewBuilder
    private var stateOverlayOrderPayment: some View {
        if case .loading = currencyChooseViewModel.stateOrderPayment {
            CustomProgressView()
        }
    }
    
    
    @ViewBuilder
    private var errorButtonsCurrencyOption: some View {
        Button("Cancel", role: .cancel) {}
        Button("Error.repeat") {
            Task { await currencyChooseViewModel.loadData() }
        }
    }
    
    @ViewBuilder
    private var errorButtonsOrderPayment: some View {
        Button("Cancel", role: .cancel) {}
        Button("Error.repeat") {
            Task { await currencyChooseViewModel.payOrder(currencyId: currencyId) }
        }
    }
}

#Preview {
    CurrencyChooseView(
        services: ServicesAssembly(
            networkClient: DefaultNetworkClient(),
            nftStorage: NftStorageImpl()
        ),
        basketViewModel: BasketViewModel(services: ServicesAssembly(
            networkClient: DefaultNetworkClient(),
            nftStorage: NftStorageImpl()
        ))
    )
}


