//
//  File.swift
//  
//
//  Created by Vladislav on 7/11/24.
//

import SwiftUI

struct UIOrientationInfoKey: EnvironmentKey {
    static let defaultValue: UIOrientation = .unknown
}

struct UISafeAreaSize: EnvironmentKey {
    static let defaultValue: CGSize = .zero
}

struct OrientationInfoKey: EnvironmentKey {
    static let defaultValue: UIDeviceOrientation = .unknown
}
