import Foundation

struct Token: Codable {
    var id: String
    var name: String
    var images: [URL?]
    var rating: Int
    var price: Double
}
