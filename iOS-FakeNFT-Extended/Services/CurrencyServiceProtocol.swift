//
//  CurrencyServiceProtocol.swift
//  iOS-FakeNFT-Extended
//
//  Created by 1111 on 04.10.2025.
//

import Foundation

protocol CurrencyServiceProtocol {
    func loadCurrencies() async throws -> [Currency]
}
