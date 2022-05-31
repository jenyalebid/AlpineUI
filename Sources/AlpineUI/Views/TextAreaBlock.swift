//
//  TextAreaBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/2/22.
//

import SwiftUI

public struct TextAreaBlock: View {
    
    var title: String
    var height: Int
    
    @FocusState private var isFocused: Bool
    
    @Binding var text: String
    @Binding var changed: Bool
    
    public init(title: String, text: Binding<String>, height: Int = 300, changed: Binding<Bool>) {
        self.title = title
        self._text = text
        self.height = height
        self._changed = changed
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("\(title):").font(.footnote)
            TextEditor(text: $text)
                .focused($isFocused)
                .frame(height: CGFloat(height))
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

struct TextAreaBlock_Previews: PreviewProvider {
    static var previews: some View {
        TextAreaBlock(title: "Comments", text: Binding.constant("Sample Text"), changed: Binding.constant(false))
    }
}
