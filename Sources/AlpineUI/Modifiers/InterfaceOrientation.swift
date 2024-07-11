//
//  InterfaceOrientation.swift
//
//
//  Created by Vladislav on 7/11/24.
//

import SwiftUI

struct InterfaceOrientation: ViewModifier {
    
    @State private var uiOrientation: UIOrientation = .unknown
    @State private var size: CGSize = .zero

    func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { geometry in
                    Rectangle()
                        .fill(.clear)
                        .onAppear {
                            getOrientation(from: geometry)
                            size = geometry.size
                        }
                        .onChange(of: geometry.size) { _, newValue in
                            getOrientation(from: geometry)
                            size = newValue
                        }
                }
                .ignoresSafeArea(.keyboard)
            }
            .environment(\.uiOrientation, uiOrientation)
            .environment(\.uiSafeArea, size)
    }
    
    private func getOrientation(from geometry: GeometryProxy) {
        if geometry.size.width > geometry.size.height {
            uiOrientation = .landcape
        }
        else {
            uiOrientation = .portrait
        }
    }
}
