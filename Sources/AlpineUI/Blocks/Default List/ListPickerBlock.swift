//
//  ListPickerBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 7/20/23.
//

import SwiftUI

public struct ListPickerBlock<PickerValue: Hashable, Style: PickerStyle, PickerValues: View>: View {
    
    var title: String
    var style: Style
    var showLabel: Bool
    
    @Binding var value: PickerValue
    @ViewBuilder var values: PickerValues
    
    public init(title: String, style: Style = .automatic, showLabel: Bool = true, value: Binding<PickerValue>, @ViewBuilder values: () -> PickerValues) {
        self.title = title
        self.style = style
        self.showLabel = showLabel
        self._value = value
        self.values = values()
    }
    
    public var body: some View {
        if showLabel {
            pickerWithTitle
        }
        else {
            picker
        }
    }
    
    var pickerWithTitle: some View {
        HStack {
            ListLabel(title)
            Spacer()
            picker
        }
    }
    
    var picker: some View {
        Picker(title, selection: $value) {
            values
        }
        .pickerStyle(style)
        .labelsHidden()
    }
}

struct ListPickerBlock_Previews: PreviewProvider {
    static var previews: some View {
        ListPickerBlock(title: "Test Picker", value: .constant(1)) {
            ForEach(0..<5) { number in
                Text("\(number)")
            }
        }
    }
}
