//
//  SuccessPaymentView.swift
//  iOS-FakeNFT-Extended
//
//  Created by 1111 on 17.09.2025.
//

import SwiftUI

struct SuccessPaymentView: View {
    let returnToCart: () -> Void
    
    var body: some View {
        VStack(spacing: .zero) {
            VStack(spacing: .zero) {
                Image(.funnyImageSuccessPayment).padding(.bottom, 20)
                Text("SuccessPayment")
                    .font(.headline3)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
            }
            .ignoresSafeArea()
            .padding(.top, 196)
            Spacer()
            Button("ReturnToCart") {
                returnToCart()
            }
            .frame(maxWidth: .infinity, maxHeight: 60)
            .font(.bodyBold)
            .background(.blackDay)
            .foregroundStyle(.whiteDay)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding([.horizontal, .bottom], 16)
        }
        .background(.appBackground)
    }
}

#Preview {
    SuccessPaymentView(returnToCart: {})
}
