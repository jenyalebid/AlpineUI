//
//  ListExpandableTextFieldBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 7/31/23.
//

import SwiftUI

internal struct ListExpandableTextFieldBlock: View {
    
    @Binding var value: String
    
    private var label: String
    private var required: Bool
    
    public init(label: String, value: Binding<String>, required: Bool = false) {
        self.label = label
        self._value = value
        self.required = required
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            ListLabel(label)
            field
        }
    }
    
    private var field: some View {
        ExpandableTextField(value: $value)
            .requiredOutline(required && value.isEmpty)
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
