import SwiftUI

struct StatisticsTabView: View {
    var viewModel = StatisticsViewModel()
    var body: some View {
        NavigationStack {
            StatisticsView(viewModel: viewModel)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            viewModel.showSortMenu = true
                        } label: {
                            Image(uiImage: .sortIcon)
                        }
                        .tint(.blackDay)
                    }
                }
        }
    }
}

#Preview {
    StatisticsTabView(viewModel: .mock)
}
