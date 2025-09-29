//
//  GridCellView.swift
//  iOS-FakeNFT-Extended
//
//  Created by 1111 on 17.09.2025.
//

import SwiftUI

struct GridCell: View {
    @ObservedObject var viewModel: GridCellViewModel
    
    let currency: MockCurrency
    
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
    GridCell(viewModel: GridCellViewModel(), currency: .mockData[0])
}
