//
//  TextFieldDisplayBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 6/2/22.
//

import SwiftUI

public struct TextFieldDisplayBlock: View {
    
    @Environment(\.isEnabled) var isEnabled
    
    var title: String
    
    @Binding var text: String
    @Binding var trigger: Bool
    @Binding var changed: Bool
    
    var required: Bool
        
    public init(title: String, text: Binding<String>, trigger: Binding<Bool> = .constant(false), required: Bool = false, changed: Binding<Bool> = .constant(false)) {
        self.title = title
        self._text = text
        self._trigger = trigger
        self.required = required
        self._changed = changed
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("\(title):").font(.footnote)
            Text(text)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 20)
                .padding(6.0)
                .foregroundColor(Color(UIColor.label))
                .overlay (
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color((required && text == "") ? UIColor.systemRed : UIColor.systemGray), lineWidth: (required && text == "") ? 1.2 : 0.2)
                )
                .background(isEnabled ? Color(UIColor.systemGray6).opacity(0.5) : Color(UIColor.systemGray3).opacity(0.5))
                .cornerRadius(5)
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .onTapGesture {
            trigger.toggle()
        }
        .onChange(of: text) { _ in
            changed.toggle()
        }
    }
}

struct TextFieldDisplayBlock_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldDisplayBlock(title: "Title", text: .constant("Text"), changed: .constant(false))
    }
}