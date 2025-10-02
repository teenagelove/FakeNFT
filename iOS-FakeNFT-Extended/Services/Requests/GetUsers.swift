import Foundation

struct GetUsers: NetworkRequest {
    var page: Int
    var size: Int
    var sortBy: String

    var query: String { "page=\(page)&size=\(size)&sortBy=\(sortBy)" }
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/users?\(query)")
    }
}
