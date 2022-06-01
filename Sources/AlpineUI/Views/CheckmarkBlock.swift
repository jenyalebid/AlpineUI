//
//  CheckmarkBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/2/22.
//

import SwiftUI

public struct CheckmarkBlock: View {
    
    @Environment(\.isEnabled) var isEnabled
    
    var text: String
    
    @Binding var checked: Bool
    @Binding var changed: Bool
    
    public init(text: String, checked: Binding<Bool>, changed: Binding<Bool>) {
        self.text = text
        self._checked = checked
        self._changed = changed
    }
    
    public var body: some View {
        HStack {
            Text("\(text):")
                .font(.subheadline)
            Image(systemName: checked ? "checkmark.square.fill" : "square")
                .foregroundColor(checked ? Color.accentColor : Color.secondary)
                .onTapGesture {
                    checked.toggle()
                    changed.toggle()
                }
                .background(isEnabled ? Color(UIColor.systemGray6).opacity(0.5) : Color(UIColor.systemGray3).opacity(0.5))
                .cornerRadius(5)
        }
    }
}

struct CheckmarkBlock_Previews: PreviewProvider {
    static var previews: some View {
        CheckmarkBlock(text: "Sample Checkmark", checked: Binding.constant(false), changed: Binding.constant(false))
    }
}
