//
//  ListBoolBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 8/1/23.
//

import SwiftUI

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

struct RequiredViewModifier: ViewModifier {
    
    var isRequired: Bool
    var padding: CGFloat
    
    init(isRequired: Bool, padding: CGFloat) {
        self.isRequired = isRequired
        self.padding = padding
    }

    func body(content: Content) -> some View {
        if isRequired {
            ZStack {
                content
                    .padding(padding)
                RoundedRectangle(cornerRadius: 5)
                    .strokeBorder(lineWidth: 1)
                    .foregroundColor(Color(uiColor: .red))
            }
        }
        else {
            content
        }
    }
}

public struct BooleanBlock: View {
    
    var label: String
    @Binding var checked: Bool
    
    public init(label: String, checked: Binding<Bool>) {
        self.label = label
        self._checked = checked
    }
    
    public var body: some View {
        HStack {
            Image(systemName: checked ? "checkmark.square.fill" : "square")
                .foregroundColor(checked ? Color.accentColor : Color.secondary)
            Text(label)
        }
        .contentShape(RoundedRectangle(cornerRadius: 5))
        .onTapGesture {
            checked.toggle()
        }
    }
}

public struct BooleanPicker: View {
    
    var leftLabel: String
    var rightLabel: String
    
    @Binding var value: NSNumber
    
    public init(leftLabel: String, rightLabel: String, value: Binding<NSNumber>) {
        self.leftLabel = leftLabel
        self.rightLabel = rightLabel
        self._value = value
    }
    
    public var body: some View {
        HStack {
            BooleanBlock(label: leftLabel, checked: .constant(value == true ? true : false))
                .simultaneousGesture(
                    TapGesture()
                        .onEnded {
                            value = true
                        }
                )
            Divider()
                .frame(height: 20)
                .padding(.horizontal)
            BooleanBlock(label: rightLabel, checked: .constant(value == false ? true : false))
                .simultaneousGesture(
                    TapGesture()
                        .onEnded {
                            value = false
                        }
                )
        }
    }
}

struct ListBoolBlock_Previews: PreviewProvider {
    static var previews: some View {
        ListBoolBlock(label: "Bool", left: "left", right: "right", value: .constant(4), required: true)
    }
}
