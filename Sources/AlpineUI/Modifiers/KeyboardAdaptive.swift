//
//  SwiftUIView.swift
//  
//
//  Created by Vladislav on 7/10/24.
//

import SwiftUI
import Combine

struct KeyboardAdaptive: ViewModifier {
    @State private var keyboardHeight: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboardHeight)
            .onReceive(Publishers.keyboardHeight) { height in
                withAnimation {
                    self.keyboardHeight = height
                }
            }
    }
}
