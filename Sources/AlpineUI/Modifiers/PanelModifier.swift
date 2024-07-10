//
//  PanelModifier.swift
//  
//
//  Created by Vladislav on 7/10/24.
//

import SwiftUI

struct PanelModifier: ViewModifier {
    
    @Binding var isPresented: Bool
    var alignment: Alignment
    
    public init(isPresented: Binding<Bool>, alignment: Alignment) {
        self._isPresented = isPresented
        self.alignment = alignment
    }
    
    public func body(content: Content) -> some View {
        content
            .background(Color(uiColor: .systemBackground))
            .cornerRadius(5)
            .shadow(radius: 2)
            .draggable(isPresented: $isPresented, alignment: alignment)
    }
}
