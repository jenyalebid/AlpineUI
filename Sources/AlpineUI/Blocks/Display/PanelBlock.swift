//
//  PanelBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/3/23.
//

import SwiftUI

public struct SizeFrame {
    
    public init(height: CGFloat? = nil, width: CGFloat? = nil, alignment: Alignment) {
        self.height = height
        self.width = width
        self.alignment = alignment
    }
    
    var height: CGFloat?
    var width: CGFloat?
    var alignment: Alignment
}

@available(iOS 16.0, *)
public struct PanelBlock<Content: View>: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    public var content: Content
    
    @Binding var isPresented: Bool
    var frame: SizeFrame
    
    public init(isPresented: Binding<Bool>, frame: SizeFrame, @ViewBuilder content: () -> Content) {
        self._isPresented = isPresented
        self.frame = frame
        self.content = content()
    }
    
    public var body: some View {
        VStack {
            if isPresented {
                panel
            }
        }
    }
    
    var panel: some View {
        content
            .frame(width: frame.width, height: frame.height)
            .background(Color(uiColor: .systemBackground))
            .cornerRadius(5)
            .shadow(radius: 2)
            .draggable(isPresented: $isPresented, alignment: frame.alignment)
    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        VStack {
//            PanelBlock(isPresented: .constant(true), frame: SizeFrame(alignment: .trailing)) {
//                Text("Hello There")
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//            }
//        }
//        .padding()
//        .background(Color.blue)
//
//    }
//}
