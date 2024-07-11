//
//  DeviceRotationViewModifier.swift
//  AlpineCore
//
//  Created by Jenya Lebid on 2/23/23.
//

import SwiftUI

public struct DeviceRotationViewModifier: ViewModifier {

    let action: (UIDeviceOrientation) -> Void
    
    public init(action: @escaping (UIDeviceOrientation) -> Void) {
        self.action = action
    }

    public func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

public extension View {

}
