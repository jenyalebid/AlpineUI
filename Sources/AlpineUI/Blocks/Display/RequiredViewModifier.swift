//
//  RequiredViewModifier.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/8/24.
//

import SwiftUI

struct RequiredViewModifier: ViewModifier {
    
    var isRequired: Bool
    var padding: CGFloat
    
    init(isRequired: Bool, padding: CGFloat) {
        self.isRequired = isRequired
        self.padding = padding
    }

    func body(content: Content) -> some View {
        if isRequired {
            ZStack {
                content
                    .padding(padding)
                RoundedRectangle(cornerRadius: 5)
                    .strokeBorder(lineWidth: 1)
                    .foregroundColor(Color(uiColor: .red))
            }
        }
        else {
            content
        }
    }
}

public extension View {
    
    func requiredOutline(_ isRequired: Bool, padding: CGFloat = 0) -> some View {
        modifier(RequiredViewModifier(isRequired: isRequired, padding: padding))
    }
}
