//
//  SelectionManager.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/16/23.
//

import SwiftUI

public class SelectionManager: ObservableObject {
    
    @Published public var selectedItem: UUID?
    
    public static var shared = SelectionManager()
 
    private init() {}

    static func select(_ guid: UUID?) {
        SelectionManager.shared.selectedItem = guid
    }
    
    static func deselect() {
        SelectionManager.shared.selectedItem = nil
    }
}
