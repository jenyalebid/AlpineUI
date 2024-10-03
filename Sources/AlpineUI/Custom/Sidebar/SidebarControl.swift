//
//  SidebarControl.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 10/3/24.
//

import SwiftUI

struct SidebarEnvironmentKey: EnvironmentKey {
    static let defaultValue: SidebarManager = SidebarManager()
}

extension EnvironmentValues {
    
    var sidebar: SidebarManager {
        get { self[SidebarEnvironmentKey.self] }
        set { self[SidebarEnvironmentKey.self] = newValue }
    }
}

@Observable
public class SidebarManager {

    enum DividerStatus {
        case visible
        case hidden
        case safeAreaTopPadding
        case safeAreaBottomPadding
    }
    
    var dividerStatus = DividerStatus.visible
    
    public init() {}
}

public extension SidebarManager {
    
    var showDivider: Bool {
        get {
            dividerStatus != .hidden
        }
        set {
            dividerStatus = newValue ? .visible : .hidden
        }
    }
    
    var dividerPaddingTop: Bool {
        get {
            dividerStatus == .safeAreaTopPadding
        }
        set {
            dividerStatus = newValue ? .safeAreaTopPadding : .visible
        }
    }
    
    var dividerPaddingBottom: Bool {
        get {
            dividerStatus == .safeAreaBottomPadding
        }
        set {
            dividerStatus = newValue ? .safeAreaBottomPadding : .visible
        }
    }
}

struct SidebarPaddingTopModifier: ViewModifier {
    
    @Environment(\.sidebar) private var sidebar
    
    public func body(content: Content) -> some View {
        content
            .onAppear {
                sidebar.dividerPaddingTop = true
            }
            .onDisappear {
                sidebar.dividerPaddingTop = false
            }
    }
}

public extension View {
    
    func sidebarDividerTopPadding() -> some View {
        modifier(SidebarPaddingTopModifier())
    }
}
