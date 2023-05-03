//
//  PanelBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/3/23.
//

import SwiftUI

public struct PanelBlock<Content: View>: View {
    
    @Environment(\.colorScheme) var colorScheme

    public var content: Content
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        content
            .zIndex(1)
            .background(Color(uiColor: .systemBackground))
            .cornerRadius(5)
            .shadow(color: Color(uiColor: colorScheme == .light ? .systemFill : .black), radius: 2)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PanelBlock {
                Text("Hello There")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .padding()
        .background(Color.blue)
        
    }
}
