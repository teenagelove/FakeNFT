//
//  GetNftOrdersRequest.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 17.09.2025.
//

import Foundation

struct GetNftOrdersRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1")
    }
}
