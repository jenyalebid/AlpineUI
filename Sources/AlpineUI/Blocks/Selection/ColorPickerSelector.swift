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
    
    var colors: [Color]
    var eventTracker: UIEventTracker?
    
    private let columns = [GridItem(.adaptive(minimum: 40))]
  
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
                            eventTracker?.logUIEvent(.colorSelected, parameters: ["selectedColor": color.description])
                        }
                }
            }
            .padding()
        }
        .frame(idealWidth: 200, maxHeight: 120)
    }
}
