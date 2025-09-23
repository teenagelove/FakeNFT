//
//  MockCurrency+Mocks.swift
//  iOS-FakeNFT-Extended
//
//  Created by 1111 on 17.09.2025.
//

import Foundation

extension MockCurrency {
    static let mockData: [MockCurrency] = [
        MockCurrency(imageName: "mockCurrency1", name: "Bitcoin", shortName: "BTC"),
        MockCurrency(imageName: "mockCurrency2", name: "Dogecoin", shortName: "DOGE"),
        MockCurrency(imageName: "mockCurrency3", name: "Tether", shortName: "USDT"),
        MockCurrency(imageName: "mockCurrency4", name: "Apecoin", shortName: "APE")
    ]
}
