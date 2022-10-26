//
//  ColorPickerBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 10/26/22.
//

import SwiftUI

public struct ColorPickerBlock: View {
    
    @Binding var color: Color
    
    var colors: [Color]
    var size: CGFloat
    
    var defaultColors: [Color] = [.red, .green, .blue, .orange, .yellow, .pink, .teal]
    
    @State private var showSelector = false
    
    public init(color: Binding<Color>, colors: [Color]? = nil, size: CGFloat = 40) {
        self._color = color
        self.size = size
        self.colors = colors ?? defaultColors
    }
    
    public var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .foregroundColor(color)
            .frame(width: size, height: size)
            .popover(isPresented: $showSelector) {
                ColorPickerSelector(color: $color, show: $showSelector, colors: colors)
            }
            .onTapGesture {
                showSelector.toggle()
            }
    }
}


struct ColorPickerSelector: View {
    
    @Binding var color: Color
    @Binding var show: Bool
    
    var colors: [Color]

    let columns = [GridItem(.adaptive(minimum: 40))]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(colors, id: \.self) { color in
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(color)
                        .frame(width: 40, height: 40)
                        .onTapGesture {
                            self.color = color
                            show.toggle()
                        }
                }
            }
            .padding()
        }
        .frame(idealWidth: 200, maxHeight: 120)
    }
}

struct ColorPickerBlock_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerBlock(color: .constant(.red))
    }
}
