//
//  WiggleEffect.swift
//  
//
//  Created by Vladislav on 7/10/24.
//

import SwiftUI

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
