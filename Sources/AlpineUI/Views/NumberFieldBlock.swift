//
//  NumberFieldBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/9/22.
//

import SwiftUI

public struct NumberFieldBlock<T>: View {
    
    var title: String
    let formatter = NumberFormatter()
    
    @FocusState private var isFocused: Bool
    
    @Binding var value: T
    @Binding var changed: Bool
    
    public init(title: String, value: Binding<T>, changed: Binding<Bool>) {
        self.title = title
        self._value = value
        self._changed = changed
        formatter.nilSymbol = ""
        formatter.numberStyle = .decimal
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("\(title):").font(.footnote)
            TextField("", value: $value, formatter: formatter)
                .keyboardType(.numberPad)
                .focused($isFocused)
                .padding(6.0)
                .overlay (
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(UIColor.systemGray), lineWidth: 0.2)
                )
                .background(Color(UIColor.systemGray6).opacity(0.5))
                .cornerRadius(5)
        }
        .onChange(of: isFocused) { _ in
            if !isFocused {
                changed.toggle()
            }
        }
    }
}
