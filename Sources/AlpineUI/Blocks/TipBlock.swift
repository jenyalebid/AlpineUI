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
    private var eventTracker: UIEventTracker?
    
    public init(_ tip: T, eventTracker: UIEventTracker? = nil, actionHandler: ((Tips.Action) -> Void)? = nil) {
        self.tip = tip
        self.actionHandler = actionHandler
        self.eventTracker = eventTracker
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
