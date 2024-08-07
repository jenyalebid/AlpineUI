//
//  ListNumberFieldBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 7/20/23.
//

import SwiftUI

public struct ListNumberFieldBlock<T>: View where T: Numeric & LosslessStringConvertible {
    
    @Environment(\.colorScheme) private var colorScheme
    
    @Binding var value: T
    
    private var label: String
    private var formatter: NumberFormatter
    private var keyboardType: UIKeyboardType
    
    public init(title: String, value: Binding<T>, formatter: NumberFormatter = NumberFormatter(), keyboardType: UIKeyboardType = .decimalPad) {
        self.label = title
        self._value = value
        self.formatter = formatter
        self.formatter.maximumIntegerDigits = 40
        self.keyboardType = keyboardType
    }
    
    public init(label: String, value: Binding<T>, formatter: NumberFormatter = NumberFormatter(), keyboardType: UIKeyboardType = .decimalPad) {
        self.label = label
        self._value = value
        self.formatter = formatter
        self.keyboardType = keyboardType
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            ListLabel(label)
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .strokeBorder()
                    .foregroundColor(Color(uiColor: .systemGray3))
                    .background(.ultraThickMaterial)
                TextField(label, value: $value, formatter: formatter)
                    .keyboardType(keyboardType)
                    .padding(.horizontal, 5)
            }
        }
    }
}

struct ListNumberFieldBlock_Previews: PreviewProvider {
    static var previews: some View {
        ListNumberFieldBlock(title: "Number", value: .constant(4))
    }
}
