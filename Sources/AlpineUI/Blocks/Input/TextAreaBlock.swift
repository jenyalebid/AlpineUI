//
//  TextAreaBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/2/22.
//

import SwiftUI

public struct TextAreaBlock: View {
    
    @Environment(\.isEnabled) var isEnabled
    
    var title: String
    var height: CGFloat?
    
    @FocusState private var isFocused: Bool
    
    @Binding var text: String
    @Binding var changed: Bool
    
    var sendKeyboardUpdate: Bool
    
    public init(title: String, text: Binding<String>, height: CGFloat?, changed: Binding<Bool>, sendKeyboardUpdate: Bool = false) {
        self.title = title
        self._text = text
        self.height = height
        self._changed = changed
        self.sendKeyboardUpdate = sendKeyboardUpdate
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("\(title):").font(.footnote)
            TextEditor(text: $text)
                .focused($isFocused)
                .frame(height: height)
                .overlay (
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(UIColor.systemGray), lineWidth: 0.2)
                )
                .background(isEnabled ? Color(UIColor.systemGray6).opacity(0.5) : Color(UIColor.systemGray3).opacity(0.5))
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

struct TextAreaBlock_Previews: PreviewProvider {
    static var previews: some View {
        TextAreaBlock(title: "Comments", text: Binding.constant("Sample Text"), height: 300, changed: Binding.constant(false))
    }
}
