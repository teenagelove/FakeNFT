import SwiftUI

struct UserCollectionItemView: View {
    var viewModel: UserCollectionItemViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            nftImage
            VStack(alignment: .leading, spacing: 4) {
                RatingView(starCount: viewModel.rating)
                details
            }
        }
        .overlay(alignment: .topTrailing) { favoriteButton }
    }
    var nftImage: some View {
        Image(uiImage: viewModel.image)
            .resizable()
            .aspectRatio(1, contentMode: .fill)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    var details: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(viewModel.title).font(.bodyBold)
                (Text(viewModel.price.formatted()) + Text(" ETH")).font(.price)
            }
            .lineLimit(1)
            .foregroundStyle(.blackDay)
            Spacer()
            cartButton
        }
    }
    var cartButton: some View {
        Button {
            viewModel.toggleInCart()
        } label: {
            viewModel.isInCart
                ? Image(uiImage: .deleteFromCart)
                : Image(uiImage: .addToCart)
        }
    }
    var favoriteButton: some View {
        Button {
            viewModel.toggleFavorite()
        } label: {
            viewModel.isFavorite
                ? Image(uiImage: .favouriteActive)
                : Image(uiImage: .favouriteInactive)
        }
    }
}

private struct RatingView: View {
    var starCount = 0
    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<5) { index in
                index < self.starCount
                ? Image(uiImage: .starYellow)
                : Image(uiImage: .starGray)
            }
        }
    }
}

#Preview("RatingView") {
    RatingView(starCount: 3)
        .border(.red)
}


#Preview {
    UserCollectionItemView(
        viewModel: .init(
            id: 0,
            image: .zeus,
            isFavorite: false,
            title: "Zeus",
            rating: 2,
            price: 1.78,
            isInCart: false
        )
    )
    .frame(width: 200)
    .fixedSize()
}
