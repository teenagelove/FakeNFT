//
//  NftCollection+Mock.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 15.09.2025.
//

import Foundation

extension NftCollection {
    static let mockData: [NftCollection] = [
        NftCollection(
            name: "singulis epicuri",
            cover: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Обложки_коллекций/Brown.png")!,
            nfts: ["c14cf3bc-7470-4eec-8a42-5eaa65f4053c", "d6a02bd1-1255-46cd-815b-656174c1d9c0", "f380f245-0264-4b42-8e7e-c4486e237504"],
            description: "curabitur feugait a definitiones singulis movet eros aeque mucius evertitur assueverit et eam",
            author: "Lourdes Harper",
            id: "d4fea6b6-91f1-45ce-9745-55431e69ef5c"
        ),
        NftCollection(
            name: "Blue",
            cover: URL(string: "https://picsum.photos/200/300?random=2")!,
            nfts: ["21", "22", "23", "24"],
            description: "Голубая коллекция NFT",
            author: "Bob",
            id: UUID().uuidString
        ),
        NftCollection(
            name: "Brown",
            cover: URL(string: "https://picsum.photos/200/300?random=3")!,
            nfts: ["31", "32", "33"],
            description: "Коричневая коллекция NFT",
            author: "Charlie",
            id: UUID().uuidString
        ),
        NftCollection(
            name: "Green",
            cover: URL(string: "https://picsum.photos/200/300?random=4")!,
            nfts: ["41", "42", "43", "44", "45"],
            description: "Зелёная коллекция NFT",
            author: "Diana",
            id: UUID().uuidString
        ),
        NftCollection(
            name: "Purple",
            cover: URL(string: "https://picsum.photos/200/300?random=5")!,
            nfts: ["51", "52", "53", "54"],
            description: "Фиолетовая коллекция NFT",
            author: "Eve",
            id: UUID().uuidString
        )
    ]
}
