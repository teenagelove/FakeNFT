import Kingfisher
import SwiftUI

struct UserCollectionItemView: View {
    var viewModel: UserCollectionItemViewModel

    @Environment(ServicesAssembly.self) var servicesAssembly
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            tokenImage
            VStack(alignment: .leading, spacing: 4) {
                RatingView(rating: viewModel.rating)
                details
            }
        }
        .overlay(alignment: .topTrailing) { favoriteButton }
        .onAppear { viewModel.loadTokenInfo(servicesAssembly: servicesAssembly) }

    }
    var tokenImage: some View {
        KFImage
            .url(viewModel.image)
            .placeholder {
                Image(systemName: "photo.badge.exclamationmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(Color(uiColor: .grayUniversal))
            }
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    var details: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(viewModel.title).font(.bodyBold)
                (Text(viewModel.price.formatted()) + Text(" ETH")).font(.medium10)
            }
            .lineLimit(2)
            .foregroundStyle(.blackDay)
            Spacer()
            cartButton
        }
    }
    var cartButton: some View {
        Button {
            viewModel.toggleInCart(servicesAssembly)
        } label: {
            Image(uiImage: viewModel.isInCart
                  ? .deleteFromCart
                  : .addToCart
            )
            .foregroundStyle(Color(uiColor: .blackDay))
        }
    }
    var favoriteButton: some View {
        Button {
            viewModel.toggleFavorite(servicesAssembly)
        } label: {
            Image(systemName: .heart)
                .foregroundColor(viewModel.isFavorite ? .redUniversal : .white)
                .frame(width: 40, height: 40)
        }
    }
}

private struct RatingView: View {
    var rating: Int
    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<5) { index in
                let uiColor: UIColor =
                    index < rating
                ? .yellowUniversal
                : .lightGray
                Image(uiImage: .star)
                    .foregroundStyle(Color(uiColor: uiColor))
            }
        }
    }
}


#Preview {
    UserCollectionItemView(
        viewModel: .init(tokenId: "1fda6f0c-a615-4a1a-aa9c-a1cbd7cc76ae")
    )
    .frame(width: 200)
    .fixedSize()
    .environment(ServicesAssembly.preview)
}
