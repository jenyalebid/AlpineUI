//
//  ListBoolBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 8/1/23.
//

import SwiftUI

public struct ListBoolBlock: View {
    
    @Binding var value: NSNumber
    
    private var label: AttributedString
    private var left: String
    private var right: String
    private var required: Bool
    private var onEvent: ((AlpineUIEvent, [String: Any]?) -> Void)?
    
    public init(label: AttributedString, left: String, right: String, value: Binding<NSNumber>, required: Bool = false, onEvent: ((AlpineUIEvent, [String: Any]?) -> Void)? = nil) {
        self.label = label
        self.left = left
        self.right = right
        self._value = value
        self.required = required
        self.onEvent = onEvent
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            ListLabel(label)
            bool
        }
    }
    
    var bool: some View {
        BooleanPicker(leftLabel: left, rightLabel: right, value: $value, onEvent: { event, parameters in
            onEvent?(event, parameters)
        })
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
