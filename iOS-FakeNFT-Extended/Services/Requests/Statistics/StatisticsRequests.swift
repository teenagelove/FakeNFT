import Foundation

enum Statistics {
    struct GetUsers: NetworkRequest {
        var endpoint: URL? {
            URL(string: "\(RequestConstants.baseURL)/api/v1/users")
        }
    }
}
