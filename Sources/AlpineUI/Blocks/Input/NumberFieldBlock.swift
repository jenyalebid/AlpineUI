//
//  NumberFieldBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/9/22.
//

import SwiftUI

public struct NumberFieldBlock: View {
    
    @Environment(\.isEnabled) private var isEnabled
    
    @FocusState private var isFocused: Bool
    
    @Binding var value: String
    @Binding var changed: Bool
    
    @State private var localValue = 0
    
    private let formatter = NumberFormatter()
    private var title: String
    private var required: Bool
    private var sendKeyboardUpdate: Bool
    
    public init(title: String, value: Binding<String>, required: Bool = false, changed: Binding<Bool>, sendKeyboardUpdate: Bool = false) {
        self.title = title
        self._value = value
        self._changed = changed
        self.required = required
        self.sendKeyboardUpdate = sendKeyboardUpdate
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
                .background(isEnabled ? Color(UIColor.systemBackground) : Color(UIColor.systemGray3).opacity(0.5))
                .cornerRadius(5)
        }
        .onChange(of: isFocused) { _ in
            if !isFocused {
                changed.toggle()
            }
            
            if sendKeyboardUpdate {
                NotificationCenter.default.post(name: Notification.Name("UI_Keyboard_Update"), object: isFocused)
            }
        }
    }
}
