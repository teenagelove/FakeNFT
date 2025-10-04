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
    var isSelected: Bool
    
    enum CodingKeys: String, CodingKey {
        case title, name, image, id
    }
    
    init(
        title: String,
        name: String,
        image: URL,
        id: String,
        isSelected: Bool = false,
    ) {
        self.title = title
        self.name = name
        self.image = image
        self.id = id
        self.isSelected = isSelected
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        name = try container.decode(String.self, forKey: .name)
        image = try container.decode(URL.self, forKey: .image)
        id = try container.decode(String.self, forKey: .id)
        isSelected = false
    }
}
