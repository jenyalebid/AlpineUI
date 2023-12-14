//
//  FillPatternPickerBlock.swift
//  AlpineUI
//
//  Created by mkv on 12/8/23.
//

import SwiftUI
import SkiaSharpKit

@available(iOS 17.0, *)
public struct FillPatternPickerBlock: View {
    
    var title: String
    @Binding var pattern: String
    var patternView: FillPatternView
    @State private var isPresented = false
    
    public init(title: String, pattern: Binding<String>, patternView: FillPatternView) {
        self.title = title
        self._pattern = pattern
        self.patternView = patternView
    }
    
    public var body: some View {
        HStack {
            ListLabel(title)
            Spacer()
            Group {
                Image(systemName: "circle.lefthalf.filled.righthalf.striped.horizontal")
                    .imageScale(.large)
            }
            .frame(width: 34, height: 34, alignment: .center)
            .simultaneousGesture(
                TapGesture()
                    .onEnded {
                        isPresented.toggle()
                    }
            )
            .popover(isPresented: $isPresented) {
                FillPatternPickerView(title: title, pattern: $pattern, patternView: patternView)
                    .frame(minWidth: 200, idealWidth: 500, maxWidth: .infinity, minHeight: 300, idealHeight: 500, maxHeight: .infinity)
            }
        }
    }
}
