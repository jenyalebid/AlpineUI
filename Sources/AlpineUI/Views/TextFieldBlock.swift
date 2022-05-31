//
//  TextFieldBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 4/29/22.
//

import SwiftUI

public struct TextFieldBlock: View {
    
    var title: String
    var placeHolder: String? = nil
    
    @FocusState private var isFocused: Bool
    
    @Binding var value: String
    @Binding var required: Bool?
    @Binding var changed: Bool
    
    public init(title: String, value: Binding<String>, required: Binding<Bool?>? = .constant(nil), changed: Binding<Bool>) {
        self.title = title
        self._value = value
        self._required = required ?? .constant(false)
        self._changed = changed
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("\(title):").font(.footnote)
            TextField(placeHolder != nil ? placeHolder! : "", text: $value)
                .focused($isFocused)
                .padding(6.0)
                .overlay (
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color((required ?? false && value == "") ? UIColor.systemRed : UIColor.systemGray), lineWidth: (required ?? false && value == "") ? 1.2 : 0.2)
                )
                .onChange(of: value) { _ in
                    if required != nil || required == false {
                        if value != "" {
                            required = false
                        }
                        else {
                            required = true
                        }
                    }
                }
                .onChange(of: isFocused) { _ in
                    if !isFocused {
                        changed.toggle()
                    }
                }
                .background(Color(UIColor.systemGray6).opacity(0.5))
                .cornerRadius(5)
        }
    }
}

struct TextFieldBlock_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldBlock(title: "Field Title", value: Binding.constant("Sample Value"), changed: Binding.constant(false))
    }
}
