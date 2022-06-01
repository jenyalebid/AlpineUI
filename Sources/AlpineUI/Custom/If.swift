//
//  If.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 6/1/22.
//

import SwiftUI

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
