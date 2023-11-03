//
//  WebView.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 11/3/23.
//

import SwiftUI
import WebKit

public struct WebView: UIViewRepresentable {
    
    let url: URL
    
    public init(url: URL) {
        self.url = url
    }
    
    public func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    public func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
