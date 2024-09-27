//
//  Navigation.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 9/27/24.
//

import SwiftUI

private struct NavigationEnvironmentKey: EnvironmentKey {
    static let defaultValue: Navigation = Navigation()
}

public extension EnvironmentValues {
    var navigation: Navigation {
        get { self[NavigationEnvironmentKey.self] }
        set { self[NavigationEnvironmentKey.self] = newValue }
    }
}

@Observable
public class Navigation {
    
    public init() {}
    
    public var path = NavigationPath()
}
