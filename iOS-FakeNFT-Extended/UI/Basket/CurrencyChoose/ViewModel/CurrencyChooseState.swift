//
//  ChooseCurrencyState.swift
//  iOS-FakeNFT-Extended
//
//  Created by 1111 on 04.10.2025.
//

enum CurrencyChooseState {
    var isFailed: Bool {
        if case .error = self { return true }
        return false
    }
    
    case loading, error(Error), success([Currency])
}
