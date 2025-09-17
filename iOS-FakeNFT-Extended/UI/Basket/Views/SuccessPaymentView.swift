//
//  SuccessPaymentView.swift
//  iOS-FakeNFT-Extended
//
//  Created by 1111 on 17.09.2025.
//

import SwiftUI

struct SuccessPaymentView: View {
    var body: some View {
        VStack(spacing: .zero) {
            VStack(spacing: .zero) {
                Image(.funnyImageSuccessPayment)
                    .padding(.bottom, 20)
                Text(NSLocalizedString("SuccessPaymentPart1", comment: ""))
                    .font(.system(size: 22, weight: .bold))
                Text(NSLocalizedString("SuccessPaymentPart2", comment: ""))
                    .font(.system(size: 22, weight: .bold))
            }
            .padding(.top, 196)
            .ignoresSafeArea()
            Spacer()
            Button(NSLocalizedString("ReturnToCart", comment: "")) {}
                .frame(maxWidth: .infinity, maxHeight: 60)
                .font(.system(size: 17, weight: .bold))
                .background(.black)
                .foregroundStyle(.white)
                .cornerRadius(16)
                .padding([.leading, .trailing, .bottom], 16)
        }
    }
}

#Preview {
    SuccessPaymentView()
}
