//
//  ListNumberFieldBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 7/20/23.
//

import SwiftUI

public struct ListNumberFieldBlock<T>: View where T: Numeric & LosslessStringConvertible {
    
    var title: String
    @Binding var value: T
    
    var formatter: NumberFormatter
    var keyboardType: UIKeyboardType
    
    public init(title: String, value: Binding<T>, formatter: NumberFormatter = NumberFormatter(), keyboardType: UIKeyboardType = .decimalPad) {
        self.title = title
        self._value = value
        self.formatter = formatter
        self.keyboardType = keyboardType
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            ListLabel(title)
            TextField(title, value: $value, formatter: formatter)
                .textFieldStyle(.roundedBorder)
                .keyboardType(keyboardType)
        }
    }
}

struct ListNumberFieldBlock_Previews: PreviewProvider {
    static var previews: some View {
        ListNumberFieldBlock(title: "Number", value: .constant(4))
    }
}
