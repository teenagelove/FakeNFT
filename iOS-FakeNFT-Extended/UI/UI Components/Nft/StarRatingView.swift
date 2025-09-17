//
//  StarRatingView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 15.09.2025.
//

import SwiftUI

struct StarRatingView: View {
    let rating: Int
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<Constants.starCount, id: \.self) { index in
                Image(systemName: .star)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(index < rating ? .yellowUniversal : .lightGrey)
            }
        }
    }
}

private enum Constants {
    static let starCount = 5
}

#Preview {
    StarRatingView(rating: 3)
        .frame(width: 100, height: 20)
}
