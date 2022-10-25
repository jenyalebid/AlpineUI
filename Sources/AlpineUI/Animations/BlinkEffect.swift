//
//  File.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 10/25/22.
//

import SwiftUI

public struct BlinkEffect: ViewModifier {
    
    @State private var animate = false
    
    public init() {}
    
    public func body(content: Content) -> some View {
        content
            .opacity(animate ? 1 : 0)
            .animation(animate ? Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true) : .default, value: animate)
            .onAppear {
                animate = true
            }
    }
}


extension View {
    
    public func blinkEffect() -> some View {
        return modifier(BlinkEffect())
    }
}
