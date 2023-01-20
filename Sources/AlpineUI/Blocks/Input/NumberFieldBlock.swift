//
//  NumberFieldBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/9/22.
//

import SwiftUI

public struct NumberFieldBlock: View {
    
    @Environment(\.isEnabled) var isEnabled
    
    var title: String
    var required: Bool
    let formatter = NumberFormatter()
    
    @FocusState private var isFocused: Bool
    
    @Binding var value: String
    @Binding var changed: Bool
    
    @State private var localValue = 0
    
    public init(title: String, value: Binding<String>, required: Bool = false, changed: Binding<Bool>) {
        self.title = title
        self._value = value
        self._changed = changed
        self.required = required
//        formatter.zeroSymbol = ""
//        formatter.numberStyle = .scientific
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("\(title):").font(.footnote)
            TextField("", text: $value)
                .keyboardType(.numberPad)
                .focused($isFocused)
                .padding(6.0)
                .overlay (
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color((required && value == "") ? UIColor.systemRed : UIColor.systemGray), lineWidth: (required  && value == "") ? 1.2 : 0.2)
                )
                .background(isEnabled ? Color(UIColor.systemGray6).opacity(0.5) : Color(UIColor.systemGray3).opacity(0.5))
                .cornerRadius(5)
        }
        .onChange(of: isFocused) { _ in
            if !isFocused {
                changed.toggle()
            }
        }
//        .onChange(of: localValue) { val in
//            value = formatter.string(from: localValue as NSNumber) as! T
//        }
        
    }
}
