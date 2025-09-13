import SwiftUI

@Observable
final class UserInformationViewModel {
    var image: UIImage
    var name: String
    var info: String
    var url: URL
    var itemsCount: Int

    init(
        image: UIImage,
        name: String,
        info: String,
        url: URL,
        itemsCount: Int
    ) {
        self.image = image
        self.name = name
        self.info = info
        self.url = url
        self.itemsCount = itemsCount
    }
}

struct UserInformationView: View {
    var viewModel: UserInformationViewModel
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                UserView(image: viewModel.image, name: viewModel.name)
                Spacer().frame(height: 20)
                Text(viewModel.info).font(.caption2)
                Spacer().frame(height: 28)
                UserSiteButton(url: viewModel.url)
                Spacer().frame(height: 41)
                UserCollectionButton(count: viewModel.itemsCount)
            }
            .padding(.horizontal)
        }
    }
}

private struct UserView: View {
    var image: UIImage
    var name: String
    var body: some View {
        HStack {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .frame(width: 70, height: 70)
                .clipShape(Circle())
            Text(name)
                .font(.headline3)
            Spacer()
        }
    }
}

private struct UserSiteButton: View {
    var url: URL
    @Environment(\.openURL) private var openURL
    var body: some View {
        Button {
            openURL(url)
        } label: {
            Capsule()
                .stroke()
                .frame(height: 40)
                .overlay {
                    Text("Перейти на сайт пользователя").font(.caption1)
                }
        }
        .tint(.blackDay)
    }
}

private struct UserCollectionButton: View {
    var count: Int
    var body: some View {
        Button {
            print("Перейти на коллекцию")
        } label: {
            HStack(spacing: 8) {
                Text("Коллекция NFT").font(.bodyBold)
                Text("(\(count))").font(.bodyBold)
                Spacer()
                Image(systemName: "chevron.right")
            }
        }
        .tint(.blackDay)
    }
}

#Preview {
    UserInformationView(
        viewModel: .init(
            image: .zeus,
            name: "Joaquin Phoenix",
            info:
                "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям.",
            url: URL(string: "https://ya.ru")!,
            itemsCount: 112
        )
    )
    .environment(
        \.openURL,
        .init {
            print("openURL", $0)
            return .discarded
        }
    )
}
