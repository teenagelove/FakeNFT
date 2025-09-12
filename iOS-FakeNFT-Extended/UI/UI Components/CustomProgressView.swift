//
//  CustomProgressView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 12.09.2025.
//

import SwiftUI

struct CustomProgressView: View {
    var body: some View {
        ProgressView()
            .tint(.primary)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    CustomProgressView()
}
