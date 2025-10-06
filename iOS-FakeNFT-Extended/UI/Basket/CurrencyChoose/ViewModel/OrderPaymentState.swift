//
//  OrderPaymentState.swift
//  iOS-FakeNFT-Extended
//
//  Created by 1111 on 04.10.2025.
//

enum OrderPaymentState {
    var isFailed: Bool {
        if case .error = self { return true }
        return false
    }
    
    case normal, loading, error(Error), success
}
