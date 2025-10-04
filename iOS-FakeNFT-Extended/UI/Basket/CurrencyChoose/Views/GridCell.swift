//
//  GridCellView.swift
//  iOS-FakeNFT-Extended
//
//  Created by 1111 on 17.09.2025.
//

import SwiftUI
import Kingfisher

struct GridCell: View {
    @Bindable var viewModel: CurrencyChooseViewModel
    
    let currency: Currency
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 12).foregroundStyle(.lightGrey)
            HStack(spacing: .zero) {
                KFImage(currency.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 36, height: 36)
                VStack(alignment: .leading, spacing: .zero) {
                    Text(currency.title).font(.system(size: 13, weight: .regular))
                    Text(currency.name)
                        .font(.system(size: 13, weight: .regular))
                        .foregroundStyle(.green)
                }.padding(.leading, 4)
            }
            .padding(.leading, 14)
            .padding(.vertical, 5)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 12).stroke(.black, lineWidth: currency.isSelected ? 1 : 0)
        )
        .onTapGesture {
            viewModel.toggleSelection(for: currency)
        }
        .frame(width: .infinity, height: 46)
    }
}

#Preview {
    GridCell(viewModel: CurrencyChooseViewModel(services: ServicesAssembly(
        networkClient: DefaultNetworkClient(),
        nftStorage: NftStorageImpl()
    )),
             currency: Currency(
                title: "Dogo",
                name: "Dogi",
                image: URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Shiba_Inu_(SHIB).png")!,
                id: "1"
             ))
}
