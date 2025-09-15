//
//  NftCollectionView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 12.09.2025.
//

import SwiftUI
import Kingfisher

struct NftCollectionView: View {
    let nftCollection: NftCollection
    @State private var viewModel: NftCollectionViewModel
    
    init(nftCollection: NftCollection, service: NftService) {
        self.nftCollection = nftCollection
        self._viewModel = State(initialValue: NftCollectionViewModel(service: service))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                coverImage
                collectionInfo
            }
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarBackButtonHidden(true)
        .toolbar { toolbar }
        .task {
            await viewModel.loadNfts(for: nftCollection.nfts)
        }
    }
}

private extension NftCollectionView {
    
    var coverImage: some View {
        KFImage(nftCollection.cover)
            .fade(duration: 0.3)
            .placeholder { SkeletonView() }
            .resizable()
            .scaledToFill()
            .frame(maxWidth: .infinity, maxHeight: 310)
            .clipShape(
                UnevenRoundedRectangle(
                    topLeadingRadius: 0,
                    bottomLeadingRadius: 12,
                    bottomTrailingRadius: 12,
                    topTrailingRadius: 0
                )
            )
    }
    
    var collectionInfo: some View {
        VStack(spacing: 24) {
            collectionHeader
            nftsGrid
        }
        .padding(.horizontal, 16)
    }
    
    var collectionHeader: some View {
        VStack(spacing: 8) {
            collectionName
            authorAndDescription
        }
    }
    
    var collectionName: some View {
        HStack(spacing: .zero) {
            Text(nftCollection.name)
                .font(.headline3)
            Spacer()
        }
    }
    
    var authorAndDescription: some View {
        VStack(alignment: .leading, spacing: .zero) {
            HStack(spacing: 4) {
                Text("Collection.Author:")
                    .font(.caption2)
                Link(nftCollection.author, destination: URL(string: "https://google.com")!)
                    .font(.caption1)
                    .foregroundColor(.blue)
                Spacer()
            }
            
            Text(nftCollection.description)
                .font(.caption2)
        }
    }
    
    var toolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) { BackButton() }
    }
    
    @ViewBuilder
    var nftsGrid: some View {
        ZStack {
            switch viewModel.state {
            case .loading: CustomProgressView()
            case .success(let nfts): NftGridView(nfts: nfts)
            case .error:
                ErrorSideView {
                    Task { await viewModel.loadNfts(for: nftCollection.nfts) }
                }
            }
        }
        .frame(minHeight: 300)
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    let service = ServicesAssembly.preview.nftService
    NftCollectionView(nftCollection: NftCollection.mockData[0], service: service)
}
