//
//  RequiredViewModifier.swift
//
//
//  Created by Vladislav on 8/7/24.
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
        } else {
            content
        }
    }
}
