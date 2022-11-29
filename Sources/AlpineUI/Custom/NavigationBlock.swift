//
//  NavigationBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 11/29/22.
//

import SwiftUI

public struct NavigationBlock<Content: View>: View {
    
    var title: String
    var mode: NavigationBarItem.TitleDisplayMode
    var content: Content

    public init(title: String, mode: NavigationBarItem.TitleDisplayMode = .inline, @ViewBuilder content: () -> Content) {
        self.title = title
        self.mode = mode
        self.content = content()
    }
    
    public var body: some View {
        NavigationView {
            content
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(mode)
        }
        .navigationViewStyle(.stack)
    }
}

struct NavigationBlock_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBlock(title: "Test") {
            
        }
    }
}
