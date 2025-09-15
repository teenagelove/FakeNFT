//
//  ErrorSideView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 15.09.2025.
//

import SwiftUI

struct ErrorSideView: View {
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            image
            errorMessage
            actionButton
        }
    }
}

private extension ErrorSideView {
    var image: some View {
        Image(systemName: .triangle)
            .resizable()
            .scaledToFit()
            .frame(width: 40, height: 40)
            .foregroundColor(.orange)
    }
    
    var errorMessage: some View {
        Text("Error.network")
            .font(.body)
            .multilineTextAlignment(.center)
            .foregroundColor(.secondary)
            .padding(.horizontal, 16)
    }
    
    var actionButton: some View {
        Button(action: action) {
            Label("Error.repeat", systemImage: .clockwise)
                .font(.headline)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.blue.opacity(0.1))
                )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ErrorSideView { }
}
