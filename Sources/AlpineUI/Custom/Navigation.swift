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

//public extension EnvironmentValues {
//    @Entry var navigation: Navigation = Navigation()
//}

@Observable
public class Navigation {
    
    public var path = NavigationPath()
    
    var isInRoot: Bool {
        path.isEmpty
    }
    
    public init() {}

    public func pop() {
        path.removeLast()
    }
    
    public func popToRoot() {
        path = NavigationPath()
    }
    
    public func push<Screen: Hashable>(_ screen: Screen) {
        path.append(screen)
    }
}
