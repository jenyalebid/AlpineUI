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
    var independent: Bool
    
    @Binding var checked: Bool
    @Binding var changed: Bool
    
    public init(text: String, checked: Binding<Bool>, changed: Binding<Bool>, independent: Bool = true) {
        self.text = text
        self._checked = checked
        self._changed = changed
        self.independent = independent
    }
    
    public var body: some View {
        HStack {
            Image(systemName: checked ? "checkmark.square.fill" : "square")
                .foregroundColor(checked ? Color.accentColor : Color.secondary)
            Text(text)
                .font(.subheadline)
                .cornerRadius(5)
        }
        .if(independent, transform: { view in
            view
                .background(isEnabled ? .clear : Color(UIColor.systemGray3).opacity(0.5))
                .onTapGesture {
                    checked.toggle()
                    changed.toggle()
                }
        })
    }
}

struct CheckmarkBlock_Previews: PreviewProvider {
    static var previews: some View {
        CheckmarkBlock(text: "Sample Checkmark", checked: Binding.constant(false), changed: Binding.constant(false))
    }
}
