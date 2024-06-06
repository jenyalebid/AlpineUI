//
//  ShakeEffect.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 6/15/23.
//

import SwiftUI

struct ShakeEffect: ViewModifier {
    
    @State private var shakes: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .modifier(Shake(animatableData: shakes))
            .simultaneousGesture(
                TapGesture()
                    .onEnded {
                        withAnimation(.linear(duration: 0.25)) {
                            shakes += 1
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                            withAnimation {
                                shakes = 0
                            }
                        }
                        
                    }
            )
    }
}

struct WiggleEffect: ViewModifier {
    let interval: TimeInterval
    @State private var rotationAngle: Double = 0.0
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: rotationAngle))
            .onAppear {
                startWiggling()
            }
    }
    
    private func startWiggling() {
        Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            withAnimation(Animation.easeInOut(duration: 0.1).repeatCount(3, autoreverses: true)) {
                rotationAngle = 5
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                rotationAngle = 0
            }
        }
    }
}

public extension View {
    
    var shakeOnTap: some View {
        modifier(ShakeEffect())
    }
    
    func wiggle(interval: TimeInterval) -> some View {
        modifier(WiggleEffect(interval: interval))
    }
}

struct Shake: GeometryEffect {
    var amount: CGFloat = 5
    var shakesPerUnit = 2
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX: amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)), y: 0))
    }
}
