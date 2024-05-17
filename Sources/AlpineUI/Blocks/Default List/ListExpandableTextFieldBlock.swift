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
    
    var required: Bool
    
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
    
    var field: some View {
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
