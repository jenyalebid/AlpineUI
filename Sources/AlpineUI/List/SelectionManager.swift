//
//  SelectionManager.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/16/23.
//

import Foundation

public class SelectionManager: ObservableObject {
    
    public static var shared = SelectionManager()
    
    @Published public var selectedItem: UUID?
    @Published public var highlightedItem: UUID?
 
    private init() {}
}

public extension SelectionManager {
    
    static func select(_ guid: UUID) {
        SelectionManager.shared.selectedItem = guid
    }
    
    static func deselect() {
        SelectionManager.shared.selectedItem = nil
    }
    
    static func highlight(_ guid: UUID) {
        SelectionManager.shared.highlightedItem = guid
    }
    
    static func unhighlight() {
        SelectionManager.shared.highlightedItem = nil
    }
}
