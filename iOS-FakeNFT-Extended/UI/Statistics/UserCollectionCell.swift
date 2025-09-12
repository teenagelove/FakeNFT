import SwiftUI

@Observable
final class UserCollectionCellViewModel {
    init(
        image: UIImage,
        isFavorite: Bool,
        title: String,
        rating: Int,
        price: Double,
        isInCart: Bool
    ) {
        self.image = image
        self.isFavorite = isFavorite
        self.title = title
        self.rating = rating
        self.price = price
        self.isInCart = isInCart
    }

    var image: UIImage
    var isFavorite: Bool
    var title: String
    var rating: Int
    var price: Double
    var isInCart: Bool

    func toggleFavorite() {
        print(#function)
        isFavorite.toggle()
    }
    func toggleInCart() {
        print(#function)
        isInCart.toggle()
    }
}

struct UserCollectionCell: View {
    var viewModel: UserCollectionCellViewModel
    var body: some View {
        let size: CGFloat = 108
        VStack(alignment: .leading, spacing: 8) {
            Image(uiImage: viewModel.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            VStack(alignment: .leading, spacing: 4) {
                RatingView(starCount: viewModel.rating)
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(viewModel.title).font(.bodyBold)
                        (Text(viewModel.price.formatted()) + Text(" ETH")).font(.price)
                    }
                    .lineLimit(1)
                    .foregroundStyle(.blackDay)
                    Spacer()
                    Button {
                        viewModel.toggleInCart()
                    } label: {
                        viewModel.isInCart
                            ? Image(uiImage: .deleteFromCart)
                            : Image(uiImage: .addToCart)
                    }
                }
                .frame(width: size)
            }
        }
        .overlay(alignment: .topTrailing) {
            Button {
                viewModel.toggleFavorite()
            } label: {
                viewModel.isFavorite
                    ? Image(uiImage: .favouriteActive)
                    : Image(uiImage: .favouriteInactive)
            }
        }
    }
}

#Preview {
    UserCollectionCell(
        viewModel: .init(
            image: .zeus,
            isFavorite: false,
            title: "Zeus",
            rating: 2,
            price: 1.78,
            isInCart: false
        )
    )
}
