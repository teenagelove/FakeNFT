//
//  WebViewBridge.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 15.09.2025.
//

import SwiftUI

struct WebViewBridge: View {
    var body: some View {
        NavigationStack {
            WebView()
                .background(.appBackground)
                .navigationBarBackButtonHidden(true)
                .navigationBarTitleDisplayMode(.inline)
                .ignoresSafeArea(edges: .bottom)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        BackButton()
                    }
                }
        }
    }
}

#Preview {
    WebViewBridge()
}
