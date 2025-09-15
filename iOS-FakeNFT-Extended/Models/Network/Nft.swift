import Foundation

struct Nft: Decodable, Identifiable {
    let name: String
    let rating: Int
    let price: Double
    let id: String
    let images: [URL]
}
