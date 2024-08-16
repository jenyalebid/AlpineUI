//
//  SwiftUIView.swift
//  
//
//  Created by Vladislav on 8/6/24.
//

import SwiftUI

internal struct ColorPickerSelector: View {
    
    @Binding var color: Color
    @Binding var show: Bool
    
    private let columns = [GridItem(.adaptive(minimum: 40))]
    
    var onEvent: ((AlpineUIEvent, [String: Any]?) -> Void)?
    var colors: [Color]
  
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
                            onEvent?(.colorAction, ["selector": "color", "action": "selected", "selectedColor": color.description])
                        }
                }
            }
            .padding()
        }
        .frame(idealWidth: 200, maxHeight: 120)
    }
}
