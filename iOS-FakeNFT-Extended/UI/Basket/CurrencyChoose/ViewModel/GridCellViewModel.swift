//
//  GridCellViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by 1111 on 25.09.2025.
//

import Foundation

final class GridCellViewModel: ObservableObject {
    @Published var gridItems: [MockCurrency] = MockCurrency.mockData
    
    func toggleSelection(for item: MockCurrency) {
        if let index = gridItems.firstIndex(where: { $0.id == item.id} ) {
            gridItems[index].isSelected.toggle()
        }
        
        for index in 0..<gridItems.count {
            if gridItems[index].id != item.id {
                gridItems[index].isSelected = false
            }
        }
    }
}
