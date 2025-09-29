//
//  BasketViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by 1111 on 23.09.2025.
//

import SwiftUI

final class BasketViewModel: ObservableObject {
    @Published var isDeleteItemViewShown: Bool = false
    var idOfBoughtNftToDelete: UUID = UUID()
}
