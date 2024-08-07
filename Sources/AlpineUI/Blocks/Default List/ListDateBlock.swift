//
//  ListDateBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 8/1/23.
//

import SwiftUI

public struct ListDateBlock: View {
    
    @Binding var value: Date
    
    private var label: String
    
    public init(label: String, value: Binding<Date>) {
        self.label = label
        self._value = value
    }
    
    public var body: some View {
        HStack {
            ListLabel(label)
            Spacer()
            DatePicker("", selection: $value)
                .labelsHidden()
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ListDateBlock(label: "Date", value: .constant(Date()))
    }
}
