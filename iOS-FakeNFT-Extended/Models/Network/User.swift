import Foundation

struct User: Codable {
    var id: String
    var avatar: URL?
    var description: String?
    var name: String
    var nfts: [String]
    var rating: String
    var website: URL
}
