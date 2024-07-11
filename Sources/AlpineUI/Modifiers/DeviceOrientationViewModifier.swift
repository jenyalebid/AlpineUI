//
//  DeviceOrientationViewModifier.swift
//  
//
//  Created by Vladislav on 7/11/24.
//

import SwiftUI


struct DeviceOrientationViewModifier: ViewModifier {
    
    @State private var orientation = UIDevice.current.orientation
    @State private var orientationChangePublisher = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)

    func body(content: Content) -> some View {
        content
            .environment(\.deviceOrientation, orientation)
            .onReceive(orientationChangePublisher) { _ in
                self.orientation = UIDevice.current.orientation
            }
    }
}
