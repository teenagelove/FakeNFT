import SwiftUI

struct TabBarView: View {
    @Environment(ServicesAssembly.self) var servicesAssembly
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = .clear
        appearance.backgroundColor = UIColor.systemBackground
        
        // Настройка цветов для неактивных
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.segmentActive
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.segmentActive]
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        TabView {
            TestCatalogView()
                .tabItem {
                    Label(
                        NSLocalizedString("Tab.catalog", comment: ""),
                        systemImage: .squareStack,
                    )
                }
            BasketView(services: servicesAssembly)
                .tabItem {
                    Image(.basketTab)
                        .renderingMode(.template)
                    Text(NSLocalizedString("Tab.basket", comment: ""))
                }
        }
        .tint(.blue)
    }
}
