import SwiftUI

struct StatisticsTabView: View {
    @State var viewModel = StatisticsViewModel()
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
    StatisticsTabView()
        .environment(ServicesAssembly.preview)
}
