//
//  SortButton.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 08.09.2025.
//

import SwiftUI

struct SortButton: View {
    // Замыкание для действия кнопки
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(.sortIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 42, height: 42)
                .foregroundColor(.blackDay)
        }
    }
}

#Preview {
    SortButton {}
}

