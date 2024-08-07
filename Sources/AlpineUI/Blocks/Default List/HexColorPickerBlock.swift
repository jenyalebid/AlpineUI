//
//  HexColorPickerBlock.swift
//  
//
//  Created by Jenya Lebid on 6/30/23.
//

import SwiftUI

public struct HexColorPickerBlock: View {
    
    @Binding var colorText: String
    @State var color: Color
    
    private var title: String
    private var eventTracker: UIEventTracker?
    
    public init(title: String, color: Binding<String>, eventTracker: UIEventTracker? = nil) {
        self.title = title
        self._color = State(wrappedValue: Color(hex: color.wrappedValue))
        _colorText = color
        self.eventTracker = eventTracker
    }
    
    public var body: some View {
        HStack {
            ListLabel(title)
            Spacer()
            ColorPicker(title, selection: $color)
                .labelsHidden()
        }
        .contentShape(Rectangle())
        .onChange(of: color) { oldValue, newValue in
            colorText = newValue.toHex()
            eventTracker?.logUIEvent(.colorPickerChanged, parameters: ["title": title, "oldColor": oldValue.toHex(), "newColor": newValue.toHex()])
        }
        .onChange(of: colorText) { oldValue, newValue in
            if color.toHex() != newValue {
                color = Color(hex: newValue)
                eventTracker?.logUIEvent(.colorTextChanged, parameters: ["title": title, "oldColorText": oldValue, "newColorText": newValue])
            }
        }
    }
}

struct HexColorPickerBlock_Previews: PreviewProvider {
    static var previews: some View {
        HexColorPickerBlock(title: "Color", color: .constant("#479FD3"))
    }
}

