import Foundation

struct Nft: Decodable {
    let name: String
    let rating: Int
    let price: Double
    let id: String
    let images: [URL]
}
