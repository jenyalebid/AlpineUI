//
//  PanelBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/3/23.
//

import SwiftUI

@available(iOS 16.0, *)
public struct PanelBlock<Content: View>: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    @Binding var isPresented: Bool
    
    public var content: Content
    
    private var alignment: Alignment
    private var onEvent: ((AlpineUIEvent, [String: Any]?) -> Void)?
    
    public init(isPresented: Binding<Bool>, alignment: Alignment, onEvent: ((AlpineUIEvent, [String: Any]?) -> Void)? = nil, @ViewBuilder content: () -> Content) {
        self._isPresented = isPresented
        self.alignment = alignment
        self.content = content()
        self.onEvent = onEvent
    }
    
    public var body: some View {
        VStack {
            if isPresented {
                panel
            }
        }
    }
    
    private var panel: some View {
        content
            .panel(isPresented: $isPresented, alignment: alignment)
            .onAppear {
                onEvent?(.panelAction, ["action": "opened", "alignment":  String(describing: alignment)])
            }
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
