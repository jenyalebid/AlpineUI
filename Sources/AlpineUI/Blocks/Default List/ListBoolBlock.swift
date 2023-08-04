//
//  ListBoolBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 8/1/23.
//

import SwiftUI
import JSwiftUI

public struct ListBoolBlock: View {
    
    var label: String
    var left: String
    var right: String
    
    var required: Bool
    
    @Binding var value: NSNumber
    
    public init(label: String, left: String, right: String, value: Binding<NSNumber>, required: Bool = false) {
        self.label = label
        self.left = left
        self.right = right
        self._value = value
        
        self.required = required
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            ListLabel(label)
            bool
        }
    }
    
    var bool: some View {
        BooleanPicker(leftLabel: left, rightLabel: right, value: $value)
            .frame(height: 26)
            .requiredOutline(required && value != 0 && value != 1)
            .frame(maxWidth: .infinity, minHeight: 26)
    }
}

struct ListBoolBlock_Previews: PreviewProvider {
    static var previews: some View {
        ListBoolBlock(label: "Bool", left: "left", right: "right", value: .constant(4), required: true)
    }
}
