//
//  PanelBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/3/23.
//

import SwiftUI

@available(iOS 16.0, *)
public struct PanelBlock<Content: View>: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    public var content: Content
    
    @Binding var isPresented: Bool
    var alignment: Alignment
    
    public init(isPresented: Binding<Bool>, alignment: Alignment, @ViewBuilder content: () -> Content) {
        self._isPresented = isPresented
        self.alignment = alignment
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
            .panel(isPresented: $isPresented, alignment: alignment)
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
