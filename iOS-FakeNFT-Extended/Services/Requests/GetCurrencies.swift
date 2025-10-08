//
//  GetCurrencies.swift
//  iOS-FakeNFT-Extended
//
//  Created by 1111 on 04.10.2025.
//

import Foundation

struct GetCurrencies: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/currencies")
    }
}
