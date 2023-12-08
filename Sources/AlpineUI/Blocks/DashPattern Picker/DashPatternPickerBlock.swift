//
//  DashPatternPickerBlock.swift
//  AlpineUI
//
//  Created by mkv on 12/8/23.
//

import SwiftUI

public struct DashPatternPickerBlock: View {
    
    var title: String
    @Binding var pattern: String
    
    @State private var isPresented = false
    
    public init(title: String, pattern: Binding<String>) {
        self.title = title
        self._pattern = pattern
    }
    
    public var body: some View {
        HStack {
            ListLabel(title)
            Spacer()
            Group {
                Image(systemName: "eye")
                // skia drawn pattern image
            }
            .frame(width: 34, height: 34, alignment: .center)
            .simultaneousGesture(
                TapGesture()
                    .onEnded {
                        isPresented.toggle()
                    }
            )
            .popover(isPresented: $isPresented) {
                DashPatternPickerView(title: title, pattern: $pattern)
                    .frame(minWidth: 300, idealWidth: 500, maxWidth: .infinity, minHeight: 400, idealHeight: 500, maxHeight: .infinity)
            }
        }
    }
}
