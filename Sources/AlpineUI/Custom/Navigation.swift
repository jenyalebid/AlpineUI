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
    
    public var path = NavigationPath()
    
    public init() {}
}

public extension Navigation {
    
    func clearStack() {
        path = NavigationPath()
    }
    
    func append<Item: Hashable>(_ item: Item) {
        path.append(item)
    }
}

public extension Navigation {
    
    var isInRoot: Bool {
        path.isEmpty
    }
}
