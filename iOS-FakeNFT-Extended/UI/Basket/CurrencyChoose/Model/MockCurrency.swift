//
//  MockCurrency.swift
//  iOS-FakeNFT-Extended
//
//  Created by 1111 on 17.09.2025.
//

import Foundation

struct MockCurrency: Hashable {
    let id: UUID = UUID()
    let imageName: String
    let name: String
    let shortName: String
    var isSelected: Bool
}
