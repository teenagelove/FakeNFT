import SwiftUI

struct TabBarView: View {
    @Environment(ServicesAssembly.self) var servicesAssembly
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBackground
        
        // Настройка цветов для неактивных
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.segmentActive
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.segmentActive]
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        TabView {
            CatalogView(viewModel: CatalogViewModel(service: servicesAssembly.nftCollectionsService))
                .tabItem {
                    Label(
                        NSLocalizedString("Tab.catalog", comment: ""),
                        systemImage: .squareStack,
                    )
                }
        }
    }
}
