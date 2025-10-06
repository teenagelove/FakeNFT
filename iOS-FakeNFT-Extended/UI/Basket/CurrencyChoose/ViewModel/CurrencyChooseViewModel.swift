//
//  CurrencyChooseViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by 1111 on 25.09.2025.
//

import SwiftUI

@MainActor
@Observable
final class CurrencyChooseViewModel {
    var isSuccessPaymentViewShown: Bool = false
    var stateCurrencyOption: CurrencyChooseState = .loading
    var stateOrderPayment: OrderPaymentState = .normal
    var savedCurrencies: [Currency] = []
    
    private var isOrderSuccessfullyPaid = false
    private let services: ServicesAssembly
    
    init(services: ServicesAssembly) {
        self.services = services
    }
    
    func loadData() async {
        stateCurrencyOption = .loading
        
        do {
            let currencies = try await services.currencyService.loadCurrencies()
            stateCurrencyOption = .success(currencies)
            
            savedCurrencies = currencies
        } catch {
            stateCurrencyOption = .error(error)
        }
    }
    
    func payOrder(currencyId: String) async {
        stateOrderPayment = .loading
        
        do {
            let orderPaymentResult = try await services.nftOrdersService.orderPayment(currencyId: currencyId)
            
            stateOrderPayment = .success
            isSuccessPaymentViewShown = orderPaymentResult.success
        } catch {
            stateOrderPayment = .error(error)
        }
    }
    
    func toggleSelection(for item: Currency) {
        if let index = savedCurrencies.firstIndex(where: { $0.id == item.id} ) {
            savedCurrencies[index].isSelected.toggle()
        }
        
        for index in 0..<savedCurrencies.count {
            if savedCurrencies[index].id != item.id {
                savedCurrencies[index].isSelected = false
            }
        }
    }
}

