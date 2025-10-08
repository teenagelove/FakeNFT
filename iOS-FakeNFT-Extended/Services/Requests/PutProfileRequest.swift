//
//  PutProfileRequest.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 17.09.2025.
//

import Foundation

struct PutProfileRequest: NetworkRequest {
    let likes: Set<String>
    
    var httpMethod: HttpMethod = .put
    
    var endpoint: URL? {
        let likes = likes.joined(separator: ",")
        
        if likes.isEmpty {
            return URL(string: "\(RequestConstants.baseURL)/api/v1/profile/1?likes=null")
        }
        
        return URL(string: "\(RequestConstants.baseURL)/api/v1/profile/1?likes=\(likes)")
    }
}
