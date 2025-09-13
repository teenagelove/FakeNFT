//
//  PlaceholderView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 13.09.2025.
//

import SwiftUI

struct PlaceholderView: View {
    @State private var move: CGFloat = -1
    
    var body: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.2))
            .overlay {
                LinearGradient(
                    gradient: Gradient(colors: [
                        .gray.opacity(0.2),
                        .gray.opacity(0.9),
                        .gray.opacity(0.2)
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .scaleEffect(x: 3, y: 1, anchor: .center)
                .offset(x: move * 300)
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: false)) {
                    move = 1
                }
            }
    }
}

#Preview {
    PlaceholderView()
}
