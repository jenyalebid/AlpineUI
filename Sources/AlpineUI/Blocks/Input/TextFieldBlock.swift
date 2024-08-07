//
//  TextFieldBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 4/29/22.
//

import SwiftUI

public struct TextFieldBlock: View {
    
    @Environment(\.isEnabled) private var isEnabled
    
    @FocusState private var isFocused: Bool
    
    @Binding var value: String
    @Binding var changed: Bool
    
    private var title: String
    private var placeholder: String
    private var required: Bool
    private var sendKeyboardUpdate: Bool

    public init(title: String, placeholder: String = "", value: Binding<String>, required: Bool = false, changed: Binding<Bool>, sendKeyboardUpdate: Bool = false) {
        self.title = title
        self.placeholder = placeholder
        self._value = value
        self.required = required
        self._changed = changed
        self.sendKeyboardUpdate = sendKeyboardUpdate
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("\(title):").font(.footnote)
            TextField(placeholder, text: $value)
                .focused($isFocused)
                .padding(6.0)
                .overlay (
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color((required && value == "") ? UIColor.systemRed : UIColor.systemGray), lineWidth: (required  && value == "") ? 1.2 : 0.2)
                )
                .onChange(of: isFocused) { _ in
                    if !isFocused {
                        changed.toggle()
                    }
                    
                    if sendKeyboardUpdate {
                        NotificationCenter.default.post(name: Notification.Name("UI_Keyboard_Update"), object: isFocused)
                    }
                }
                .background(isEnabled ? Color(UIColor.systemBackground) : Color(UIColor.systemGray3).opacity(0.5))
                .cornerRadius(5)
        }
    }
}

struct TextFieldBlock_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldBlock(title: "Field Title", value: Binding.constant("Sample Value"), changed: Binding.constant(false))
    }
}
