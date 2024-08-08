//
//  ColorPickerBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 10/26/22.
//

import SwiftUI

public struct ColorPickerBlock: View {
    
    @Binding var color: Color
    @State private var showSelector = false
    
    private var colors: [Color]
    private var size: CGFloat
    private var defaultColors: [Color] = [.red, .green, .blue, .orange, .yellow, .pink, .teal]
    private var eventTracker: UIEventTracker?
    
    public init(color: Binding<Color>, colors: [Color]? = nil, size: CGFloat = 40, eventTracker: UIEventTracker? = nil) {
        self._color = color
        self.size = size
        self.colors = colors ?? defaultColors
        self.eventTracker = eventTracker
    }
    
    public var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .foregroundColor(color)
            .frame(width: size, height: size)
            .popover(isPresented: $showSelector) {
                ColorPickerSelector(color: $color, show: $showSelector, eventTracker: eventTracker, colors: colors)
            }
            .onTapGesture {
                showSelector.toggle()
                eventTracker?.logUIEvent(.colorSelectorOpened, parameters: ["currentColor": color.description])
            }
    }
}


struct ColorPickerBlock_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerBlock(color: .constant(.red))
    }
}
