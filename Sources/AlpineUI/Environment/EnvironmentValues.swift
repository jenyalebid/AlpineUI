//
//  File.swift
//  
//
//  Created by Vladislav on 7/11/24.
//

import SwiftUI

public extension EnvironmentValues {
    
    var uiOrientation: UIOrientation {
        get { self[UIOrientationInfoKey.self] }
        set { self[UIOrientationInfoKey.self] = newValue }
    }
    
    var uiSafeArea: CGSize {
        get { self[UISafeAreaSize.self] }
        set { self[UISafeAreaSize.self] = newValue }
    }
    
    var deviceOrientation: UIDeviceOrientation {
        get { self[OrientationInfoKey.self] }
        set { self[OrientationInfoKey.self] = newValue }
    }
    
    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }
}
