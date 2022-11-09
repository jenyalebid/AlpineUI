//
//  AppPopup.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 11/8/22.
//

import SwiftUI

public struct AppPopup<Content: View> {
    
    public init(alignment: Alignment = .center, direction: Alignment = .bottom, @ViewBuilder content: () -> Content) {
        self.alignment = alignment
        self.direction = direction
        self.content = content()
    }
    
    public var alignment: Alignment
    public var direction: Alignment
    public var content: Content
}
