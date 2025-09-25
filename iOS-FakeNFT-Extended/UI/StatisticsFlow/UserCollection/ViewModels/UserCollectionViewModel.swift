import UIKit

@MainActor
@Observable
final class UserCollectionViewModel {
    init(items: [UserCollectionItemViewModel]) {
        self.items = items
    }
    var items: [UserCollectionItemViewModel]
}
