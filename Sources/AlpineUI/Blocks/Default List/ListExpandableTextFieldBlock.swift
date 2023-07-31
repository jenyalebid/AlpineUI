//
//  ListExpandableTextFieldBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 7/31/23.
//

import SwiftUI

public struct ListExpandableTextFieldBlock: View {
    
    var label: String
    @Binding var value: String
    
    public init(label: String, value: Binding<String>) {
        self.label = label
        self._value = value
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            ListLabel(label)
                .padding(.top)
            field
        }
    }
    
    var field: some View {
        ScrollView(showsIndicators: false) {
            ZStack {
                TextEditor(text: $value)
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder()
                    .foregroundColor(Color(uiColor: .systemGray6))
            }
            .frame(minHeight: 40, maxHeight: 200)
        }
    }
}

struct ListExpandableTextFieldBlock_Previews: PreviewProvider {
    
    @State static var value: String = ""
    
    static var previews: some View {
        List {
            ListExpandableTextFieldBlock(label: "Test", value: $value)
        }
    }
}
