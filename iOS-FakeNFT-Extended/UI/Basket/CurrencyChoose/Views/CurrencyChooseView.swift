//
//  CurrencyChooseView.swift
//  iOS-FakeNFT-Extended
//
//  Created by 1111 on 17.09.2025.
//

import SwiftUI

struct CurrencyChooseView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 7) {
            ForEach(MockCurrency.mockData, id: \.self) { currency in
                GridCellView(currency: currency)
            }
        }
        .padding(.top, 20)
        .padding([.leading, .trailing], 16)
        .toolbarRole(.editor)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(NSLocalizedString("CurrencyChooseToPay", comment: "")).font(.bodyBold)
            }
        }
        Spacer()
        ZStack {
            UnevenRoundedRectangle(topLeadingRadius: 12, topTrailingRadius: 12).foregroundStyle(.lightGrey)
            VStack(alignment: .leading, spacing: .zero) {
                VStack(alignment: .leading, spacing: .zero) {
                    Text(NSLocalizedString("UserAgreementPart1", comment: "")).font(.caption2)
                    Text(NSLocalizedString("UserAgreementPart2", comment: ""))
                        .font(.caption2)
                        .foregroundStyle(.blue)
                }.padding([.top, .leading], 16)
                Spacer()
                Button(NSLocalizedString("Pay", comment: "")) {
                }
                .frame(maxWidth: .infinity, maxHeight: 60)
                .font(.bodyBold)
                .background(.black)
                .foregroundStyle(.white)
                .cornerRadius(16)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 50, trailing: 12))
            }
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: 152)
    }
}




