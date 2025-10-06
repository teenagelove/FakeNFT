//
//  OrderPaymentResult.swift
//  iOS-FakeNFT-Extended
//
//  Created by 1111 on 06.10.2025.
//

import Foundation

struct OrderPaymentResult: Decodable {
    let success: Bool
    let orderId: String
    let id: String
}
