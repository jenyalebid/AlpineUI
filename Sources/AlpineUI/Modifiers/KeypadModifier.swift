//
//  SwiftUIView.swift
//  AlpineUI
//
//  Created by Vladislav on 10/1/24.
//

import SwiftUI

struct KeypadModifier<N: Numeric & LosslessStringConvertible>: ViewModifier {
    
    @Environment(\.horizontalSizeClass) private var hSizeClass
    
    @Binding var value: N
    
    @State private var showPad = false
    
    var limit: Int?

    func body(content: Content) -> some View {
        content
            .disabled(true)
            .overlay(
                Rectangle()
                    .foregroundColor(Color.orange.opacity(0.01))
                    .onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        showPad.toggle()
                    }
            )
            .popover(isPresented: $showPad) {
                KeypadView(value: $value, limit: limit, isCompact: hSizeClass != .regular)
            }
    }
}
