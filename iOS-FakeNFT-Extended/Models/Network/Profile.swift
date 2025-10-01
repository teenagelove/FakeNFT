//
//  Profile.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 17.09.2025.
//

struct Profile: Codable {
    let name: String
    let avatar: String
    let description: String
    let website: String
    let nfts: [String]
    let likes: [String]
    let id: String
}
