import Foundation

struct Nft: Decodable, Identifiable {
    let name: String
    let rating: Int
    let price: Double
    let id: String
    let images: [URL]
    let isLiked: Bool
    let isOrdered: Bool
    
    enum CodingKeys: String, CodingKey {
        case name, rating, price, id, images
    }
    
    init(
        name: String,
        rating: Int,
        price: Double,
        id: String,
        images: [URL],
        isLiked: Bool = false,
        isOrdered: Bool = false
    ) {
        self.name = name
        self.rating = rating
        self.price = price
        self.id = id
        self.images = images
        self.isLiked = isLiked
        self.isOrdered = isOrdered
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        rating = try container.decode(Int.self, forKey: .rating)
        price = try container.decode(Double.self, forKey: .price)
        id = try container.decode(String.self, forKey: .id)
        images = try container.decode([URL].self, forKey: .images)
        isLiked = false
        isOrdered = false
    }
}
