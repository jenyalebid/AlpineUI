//
//  ListPickerBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 7/20/23.
//

import SwiftUI

public struct ListPickerBlock<PickerValue: Hashable, Style: PickerStyle, PickerValues: View>: View {
    
    @Binding var value: PickerValue
    @ViewBuilder var values: PickerValues
    
    private var title: String
    private var style: Style
    private var showLabel: Bool
    
    public init(title: String, style: Style = .automatic, value: Binding<PickerValue>, @ViewBuilder values: () -> PickerValues) {
        self.title = title
        self.style = style
        self._value = value
        self.values = values()
        
        self.showLabel = true
    }
    
    public init(style: Style = .automatic, value: Binding<PickerValue>, @ViewBuilder values: () -> PickerValues) {
        self.style = style
        self._value = value
        self.values = values()
        
        title = ""
        showLabel = false
    }
    
    public var body: some View {
        if showLabel {
            pickerWithTitle
        } else {
            picker
        }
    }
    
    private var pickerWithTitle: some View {
        HStack {
            ListLabel(title)
            Spacer()
            picker
        }
    }
    
    private var picker: some View {
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
