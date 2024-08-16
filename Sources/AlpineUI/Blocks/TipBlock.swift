//
//  TipBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 6/28/24.
//

import SwiftUI
import TipKit

public struct TipBlock<T: Tip>: View {
    
    private var tip: T
    private var actionHandler: ((Tips.Action) -> Void)?
    private var onEvent: ((AlpineUIEvent, [String: Any]?) -> Void)?
    
    public init(_ tip: T, onEvent: ((AlpineUIEvent, [String: Any]?) -> Void)? = nil, actionHandler: ((Tips.Action) -> Void)? = nil) {
        self.tip = tip
        self.actionHandler = actionHandler
        self.onEvent = onEvent
    }

    public var body: some View {
        TipView(tip) { action in
            actionHandler?(action)
        }
        .tipBackground(Color.accentColor.opacity(0.10))
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .listRowBackground(EmptyView())
        .listRowSeparator(.hidden)
    }
}
