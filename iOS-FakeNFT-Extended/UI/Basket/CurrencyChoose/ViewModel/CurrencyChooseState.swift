//
//  ChooseCurrencyState.swift
//  iOS-FakeNFT-Extended
//
//  Created by 1111 on 04.10.2025.
//

import Foundation

enum CurrencyChooseState {
    var isFailed: Bool {
        if case .error = self { return true }
        return false
    }
    
    case loading, error(Error), success([Currency])
}
