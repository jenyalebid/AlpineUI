//
//  TipBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 6/28/24.
//

import SwiftUI
import TipKit

public struct TipBlock<T: Tip>: View {
    
    public init(_ tip: T) {
        self.tip = tip
    }
    
    var tip: T
    
    public var body: some View {
        TipView(tip)
            .tipBackground(Color.accentColor.opacity(0.10))
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowBackground(EmptyView())
            .listRowSeparator(.hidden)
    }
}

