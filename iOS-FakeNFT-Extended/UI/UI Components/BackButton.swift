//
//  BackButton.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 15.09.2025.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: .chevronLeft)
                .tint(.blackDay)
                .frame(width: 24, height: 24)
        }
    }
}

#Preview {
    BackButton()
}
