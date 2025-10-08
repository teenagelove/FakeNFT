import Kingfisher
import SwiftUI

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
        .navigationBarBackButtonHidden(true)
        .toolbar { ToolbarItem(placement: .topBarLeading) { BackButton() } }
        .background(.appBackground)
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
                    Text("website.go").font(.caption1)
                }
        }
        .tint(.blackDay)

    }
    var userCollectionButton: some View {
        NavigationLink {
            UserCollectionView(viewModel: viewModel.userCollectionViewModel)
        } label: {
            HStack(spacing: 8) {
                Text("Collection.title").font(.bodyBold)
                Text("(\(viewModel.userCollectionViewModel.items.count))").font(.bodyBold)
                Spacer()
                Image(systemName: "chevron.right")
            }
        }
        .tint(.blackDay)

    }
}

#Preview {
    NavigationStack {
        UserInformationView(
            viewModel: .init(
                index: 0,
                avatar: nil,
                info:
                    "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям.",
                name: "Joaquin Phoenix",
                userCollectionViewModel: .init(
                    items: [
                        "d6a02bd1-1255-46cd-815b-656174c1d9c0",
                        "de7c0518-6379-443b-a4be-81f5a7655f48",
                        "7773e33c-ec15-4230-a102-92426a3a6d5a",
                        "eb959204-76cc-46ef-ba07-aefa036ca1a5",
                        "1464520d-1659-4055-8a79-4593b9569e48",
                        "82570704-14ac-4679-9436-050f4a32a8a0",
                    ].map(UserCollectionItemViewModel.init)
                ),
                rating: "5",
                website: URL(string: "https://ya.ru")!
            )
        )
    }
    .environment(
        \.openURL,
        .init {
            print("openURL", $0)
            return .discarded
        }
    )
    .environment(ServicesAssembly.preview)
}
