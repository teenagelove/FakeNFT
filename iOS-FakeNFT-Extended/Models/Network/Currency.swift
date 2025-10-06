//
//  Currency.swift
//  iOS-FakeNFT-Extended
//
//  Created by 1111 on 04.10.2025.
//

import Foundation

struct Currency: Decodable, Hashable {
    let title: String
    let name: String
    let image: URL
    let id: String
    var isSelected: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case title, name, image, id
    }
}
