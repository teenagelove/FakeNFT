import SwiftUI

struct TabBarView: View {
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
            TestCatalogView()
                .tabItem {
                    Label(
                        NSLocalizedString("Tab.catalog", comment: ""),
                        systemImage: .squareStack,
                    )
                }
            StatisticsTabView()
                .tabItem {
                    Label(
                        NSLocalizedString("Tab.statistics", comment: ""),
                        systemImage: .crossedFlags,
                    )
                }
        }
    }
}
