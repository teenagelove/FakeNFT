//
//  WebView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 15.09.2025.
//

import SwiftUI
import WebKit

private enum Constants {
    static let url = "https://yandex.ru/legal/practicum_termsofuse/ru/"
}

struct WebView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: Constants.url) else { return WKWebView() }
        let webView = WKWebView()
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
