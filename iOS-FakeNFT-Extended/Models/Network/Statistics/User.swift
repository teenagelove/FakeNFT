import Foundation

struct User: Codable, Identifiable {
    var id: String
    
    var avatar: URL
    var description: String
    var name: String
    var ntfs: [String]
    var rating: String
    var website: URL
}
