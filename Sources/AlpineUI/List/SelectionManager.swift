//
//  SelectionManager.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/16/23.
//

import SwiftUI

public class SelectionManager: ObservableObject {
    
    public static var shared = SelectionManager()
    
    @Published public var selectedItem: UUID?
 
    private init() {}
}

public extension SelectionManager {
    
    static func select(_ guid: UUID?) {
        SelectionManager.shared.selectedItem = guid
    }
    
    static func deselect() {
        SelectionManager.shared.selectedItem = nil
    }
}

struct SelectionModifier: ViewModifier {
    
    @ObservedObject var manager = SelectionManager.shared
    
    var selectedColor = Color(hex: "A2C285")
    var regularColor = Color(uiColor: .systemBackground)
    
    var guid: UUID?
    
    init(guid: UUID?) {
        self.guid = guid
    }
    
    func body(content: Content) -> some View {
        content
            .background(backgroundColor)
    }
    
    var backgroundColor: Color {
        guard let guid else {
            return regularColor
        }
        if manager.selectedItem == guid {
            return selectedColor
        }
        return regularColor
    }
}

public extension View {
    
    func selectable(for id: UUID?) -> some View {
        modifier(SelectionModifier(guid: id))
    }
}
