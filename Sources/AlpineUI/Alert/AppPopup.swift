//
//  AppPopup.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 11/8/22.
//

import SwiftUI

public struct AppPopup {
    
    public init(alignment: Alignment = .center, direction: Alignment = .bottom, view: AnyView) {
        self.alignment = alignment
        self.direction = direction
        self.view = view
    }
    
    public var alignment: Alignment
    public var direction: Alignment
    public var view: AnyView
}
