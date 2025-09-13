import SwiftUI

struct UserCollectionView: View {
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var items: [UserCollectionItemViewModel]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 28) {
                ForEach(items) { item in
                    UserCollectionItemView(viewModel: item)
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    UserCollectionView(
        items: [
            .init(
                id: 0,
                image: .zeus,
                isFavorite: false,
                title: "Zeus 1",
                rating: 2,
                price: 1.78,
                isInCart: false
            ),
            .init(
                id: 1,
                image: .zeus,
                isFavorite: true,
                title: "Zeus 2",
                rating: 2,
                price: 1.78,
                isInCart: true
            ),
            .init(
                id: 2,
                image: .zeus,
                isFavorite: false,
                title: "Zeus 3",
                rating: 2,
                price: 1.78,
                isInCart: false
            ),
            .init(
                id: 3,
                image: .zeus,
                isFavorite: true,
                title: "Zeus 4",
                rating: 2,
                price: 1.78,
                isInCart: false
            ),
            .init(
                id: 4,
                image: .zeus,
                isFavorite: false,
                title: "Zeus 5",
                rating: 2,
                price: 1.78,
                isInCart: true
            ),
        ]
    )
}
