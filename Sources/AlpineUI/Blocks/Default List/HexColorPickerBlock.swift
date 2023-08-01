//
//  HexColorPickerBlock.swift
//  
//
//  Created by Jenya Lebid on 6/30/23.
//

import SwiftUI

public struct HexColorPickerBlock: View {
    
    @State var color: Color
    
    var title: String
    @Binding var colorText: String
    
    public init(title: String, color: Binding<String>) {
        self.title = title
        self._color = State(wrappedValue: Color(hex: color.wrappedValue))
        _colorText = color
    }
    
    public var body: some View {
        HStack {
            ListLabel(title)
            Spacer()
            ColorPicker(title, selection: $color)
                .labelsHidden()
        }
        .contentShape(Rectangle())
        .onChange(of: color) { newValue in
            colorText = newValue.toHex()
        }
        .onChange(of: colorText) { newValue in
            if color.toHex() != newValue {
                color = Color(hex: newValue)
            }
        }
    }
}

struct HexColorPickerBlock_Previews: PreviewProvider {
    static var previews: some View {
        HexColorPickerBlock(title: "Color", color: .constant("#479FD3"))
    }
}
