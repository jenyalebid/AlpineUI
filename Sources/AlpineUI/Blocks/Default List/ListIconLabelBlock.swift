//
//  ListIconLabelBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 12/11/23.
//

import SwiftUI

public struct ListIconLabelBlock<Content: View>: View {
    
    var systemImage: String
    var title: String
    
    @ViewBuilder var content: Content
    
    public init(systemImage: String, title: String, @ViewBuilder content: () -> Content) {
        self.systemImage = systemImage
        self.title = title
        self.content = content()
    }
    
    public var body: some View {
        HStack {
            ListIconTextFieldBlock(systemImage: systemImage, title: title)
            Spacer()
            content
        }
    }
}

#Preview {
    ListIconLabelBlock(systemImage: "network", title: "Network") {
        
    }
}
