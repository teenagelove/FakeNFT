//
//  MockBoughtNft+Mock.swift
//  iOS-FakeNFT-Extended
//
//  Created by 1111 on 17.09.2025.
//

import Foundation

final class MockBoughtNft: ObservableObject {
    
    @Published var nfts: [MockBoughtNftModel] = [
        MockBoughtNftModel(imageName: "mockBoughtImagesNft1", name: "April", rating: 1, price: 1.78),
        MockBoughtNftModel(imageName: "mockBoughtImagesNft2", name: "Greena", rating: 3, price: 1.78),
        MockBoughtNftModel(imageName: "mockBoughtImagesNft3", name: "Spring", rating: 5, price: 1.78)
    ]
}
