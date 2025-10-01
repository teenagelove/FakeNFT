//
//  PutNftOrdersRequest.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 17.09.2025.
//

import Foundation

struct PutNftOrdersRequest: NetworkRequest {
    let nfts: Set<String>
    
    var httpMethod: HttpMethod = .put
    
    var endpoint: URL? {
        let nfts = nfts.joined(separator: ",")
        
        if nfts.isEmpty {
            return URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1")
        }
        
        return URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1?nfts=\(nfts)")
    }
}
