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
    
    private let mockCurrencies: [MockCurrency] = [
        MockCurrency(imageName: "mockCurrency1", name: "Bitcoin", shortName: "BTC"),
        MockCurrency(imageName: "mockCurrency2", name: "Dogecoin", shortName: "DOGE"),
        MockCurrency(imageName: "mockCurrency3", name: "Tether", shortName: "USDT"),
        MockCurrency(imageName: "mockCurrency4", name: "Apecoin", shortName: "APE")
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 7) {
            ForEach(mockCurrencies, id: \.self) { currency in
                GridCellView(currency: currency)
            }
        }
        .padding(.top, 20)
        .padding([.leading, .trailing], 16)
        .toolbarRole(.editor)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(NSLocalizedString("CurrencyChooseToPay", comment: ""))
                    .font(.system(size: 17, weight: .bold))
            }
        }
        Spacer()
        ZStack {
            UnevenRoundedRectangle(topLeadingRadius: 12, topTrailingRadius: 12)
                .foregroundStyle(.lightGrey)
            VStack(alignment: .leading, spacing: .zero) {
                VStack(alignment: .leading, spacing: .zero) {
                    Text(NSLocalizedString("UserAgreementPart1", comment: ""))
                        .font(.system(size: 13, weight: .regular))
                    Text(NSLocalizedString("UserAgreementPart2", comment: ""))
                        .font(.system(size: 13, weight: .regular))
                        .foregroundStyle(.blue)
                }.padding([.top, .leading], 16)
                Spacer()
                Button(NSLocalizedString("Pay", comment: "")) {
                }
                .frame(maxWidth: .infinity, maxHeight: 60)
                .font(.system(size: 17, weight: .bold))
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

#Preview {
    CurrencyChooseView()
}

private struct MockCurrency: Hashable {
    let imageName: String
    let name: String
    let shortName: String
}

private struct GridCellView: View {
    @State private var isCellSelected = false
    
    var currency: MockCurrency
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 12).foregroundStyle(.lightGrey)
            HStack(spacing: .zero) {
                Image(currency.imageName)
                VStack(alignment: .leading, spacing: .zero) {
                    Text(currency.name).font(.system(size: 13, weight: .regular))
                    Text(currency.shortName)
                        .font(.system(size: 13, weight: .regular))
                        .foregroundStyle(.green)
                }.padding(.leading, 4)
            }
            .padding(.leading, 14)
            .padding([.top, .bottom], 5)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.black, lineWidth: isCellSelected ? 1 : 0)
        )
        .onTapGesture {
            isCellSelected = true
        }
        .frame(width: .infinity, height: 46)
    }
}
