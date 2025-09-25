//
//  CurrencyChooseView.swift
//  iOS-FakeNFT-Extended
//
//  Created by 1111 on 17.09.2025.
//

import SwiftUI

struct CurrencyChooseView: View {
    @StateObject private var currencyChooseViewModel = CurrencyChooseViewModel()
    @StateObject var gridCellViewModel = GridCellViewModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    //    MARK: for the next part
    //    var selectedId: UUID {
    //        let selectedItem = gridCellViewModel.gridItems.filter { $0.isSelected == true }
    //        return selectedItem[0].id
    //    }
    
    var body: some View {
        VStack(spacing: .zero) {
            LazyVGrid(columns: columns, spacing: 7) {
                ForEach(gridCellViewModel.gridItems, id: \.self) { currency in
                    GridCell(
                        viewModel: gridCellViewModel,
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
                    }.padding([.top, .leading], 16)
                    Spacer()
                    Button("Pay") {
                        currencyChooseViewModel.isSuccessPaymentViewShown = true
                    }
                    .frame(maxWidth: .infinity, maxHeight: 60)
                    .font(.bodyBold)
                    .background(.black)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 50, trailing: 12))
                }
            }
            .ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: 152)
        }
        .toolbarRole(.editor)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("CurrencyChooseToPay").font(.bodyBold)
            }
        }
        .fullScreenCover(isPresented: $currencyChooseViewModel.isSuccessPaymentViewShown) {
            SuccessPaymentView()
        }
    }
}

#Preview {
    CurrencyChooseView()
}


