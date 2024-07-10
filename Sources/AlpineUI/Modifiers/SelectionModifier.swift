//
//  SwiftUIView.swift
//
//
//  Created by Vladislav on 7/10/24.
//

import SwiftUI

struct SelectionModifier: ViewModifier {
    
    @ObservedObject private var manager = SelectionManager.shared
    
    private var selectedColor = Color(hex: "A2C285")
    private var regularColor = Color(uiColor: .systemBackground)
    private var guid: UUID?
    
    init(guid: UUID?) {
        self.guid = guid
    }
    
    func body(content: Content) -> some View {
        content
            .background(backgroundColor)
    }
    
    private var backgroundColor: Color {
        guard let guid else {
            return regularColor
        }
        if manager.selectedItem == guid {
            return selectedColor
        }
        return regularColor
    }
}
