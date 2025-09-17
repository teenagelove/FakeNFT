//
//  Nft+Ext.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 17.09.2025.
//

extension Nft {
    func toggledLike() -> Nft {
        isLiked ? unliked() : liked()
    }
    
    func toggledOrder() -> Nft {
        isOrdered ? removeFromOrder() : addToOrder()
    }
}

// MARK: - Private methods
private extension Nft {
    func liked() -> Nft {
        Nft(
            name: name,
            rating: rating,
            price: price,
            id: id,
            images: images,
            isLiked: true,
            isOrdered: isOrdered
        )
    }
    
    func unliked() -> Nft {
        Nft(
            name: name,
            rating: rating,
            price: price,
            id: id,
            images: images,
            isLiked: false,
            isOrdered: isOrdered
        )
    }
    
    func addToOrder() -> Nft {
        Nft(
            name: name,
            rating: rating,
            price: price,
            id: id,
            images: images,
            isLiked: isLiked,
            isOrdered: true
        )
    }
    
    func removeFromOrder() -> Nft {
        Nft(
            name: name,
            rating: rating,
            price: price,
            id: id,
            images: images,
            isLiked: isLiked,
            isOrdered: false
        )
    }
}
