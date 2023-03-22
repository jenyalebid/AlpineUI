//
//  BlinkEffect.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 10/25/22.
//

import SwiftUI

public struct BlinkEffect: ViewModifier {
    
    @State private var animate = false
    var minValue = 0.0
    var maxValue = 1.0
    
    public init(minimum: Double = 0, maximum: Double = 1) {
        minValue = minimum
        maxValue = maximum
        if minValue < 0 || minValue > 1 {
            minValue = 0
        }
        if maxValue < 0 || maxValue > 1 {
            maxValue = 1
        }
    }
    
    public func body(content: Content) -> some View {
        content
            .opacity(animate ? maxValue : minValue)
            .animation(animate ? Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true) : .default, value: animate)
            .onAppear {
                animate = true
            }
    }
}


extension View {
    
    public func blinkEffect(minimum: Double = 0, maximum: Double = 1) -> some View {
        return modifier(BlinkEffect(minimum: minimum, maximum: maximum))
    }
}
