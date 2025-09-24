import SwiftUI
import Kingfisher

struct UserInformationView: View {
    var viewModel: UserViewModel
    
    @Environment(\.openURL) private var openURL
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                userView
                Spacer().frame(height: 20)
                Text(viewModel.info ?? "").font(.caption2)
                Spacer().frame(height: 28)
                userSiteButton
                Spacer().frame(height: 41)
                userCollectionButton
            }
            .padding(.horizontal)
        }
    }
    var userView: some View {
        HStack {
            KFImage
                .url(viewModel.avatar)
                .placeholder {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                }
                .resizable()
                .aspectRatio(contentMode: .fill)
                .foregroundStyle(Color(uiColor: .grayUniversal))
                .frame(width: 70, height: 70)
                .clipShape(Circle())
            Text(viewModel.name)
                .font(.headline3)
            Spacer()
        }
    }
    var userSiteButton: some View {
        Button {
            openURL(viewModel.website)
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
    var userCollectionButton: some View {
        Button {
            print("Перейти на коллекцию")
        } label: {
            HStack(spacing: 8) {
                Text("Коллекция NFT").font(.bodyBold)
                Text("(\(viewModel.nfts.count))").font(.bodyBold)
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
            index: 0,
            avatar: nil,
            info: "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям.",
            name: "Joaquin Phoenix",
            nfts: Array(repeating: "", count: 112),
            rating: "5",
            website: URL(string: "https://ya.ru")!
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
