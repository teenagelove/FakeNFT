//
//  DeleteItemView.swift
//  iOS-FakeNFT-Extended
//
//  Created by 1111 on 17.09.2025.
//

import SwiftUI

struct DeleteItemView: View {
    var body: some View {
        VStack(spacing: .zero) {
            Image(.funnyImageDeleteItem)
                .padding(.bottom, 12)
            Text(NSLocalizedString("DeleteItemPart1", comment: ""))
                .font(.system(size: 13, weight: .regular))
            Text(NSLocalizedString("DeleteItemPart2", comment: ""))
                .font(.system(size: 13, weight: .regular))
            HStack(spacing: .zero) {
                Button(NSLocalizedString("Delete", comment: "")) {}
                    .frame(maxWidth: .infinity, maxHeight: 44)
                    .font(.system(size: 17, weight: .regular))
                    .background(.black)
                    .foregroundStyle(.red)
                    .cornerRadius(12)
                    .padding(.trailing, 8)
                    .padding(.leading, 56)
                Button(NSLocalizedString("Return", comment: "")) {}
                    .frame(maxWidth: .infinity, maxHeight: 44)
                    .font(.system(size: 17, weight: .regular))
                    .background(.black)
                    .foregroundStyle(.white)
                    .cornerRadius(12)
                    .padding(.trailing, 57)
            }
            .padding(.top, 20)
        }
    }
}

#Preview {
    DeleteItemView()
}
