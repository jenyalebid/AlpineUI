//
//  ListLabelBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 7/27/23.
//

import SwiftUI

public struct ListLabelBlock<Content: View>: View {
    
    var label: String
    @ViewBuilder var content: Content
    
    public init(label: String, @ViewBuilder content: () -> Content) {
        self.label = label
        self.content = content()
    }

    public var body: some View {
        HStack {
            ListLabel(label)
            Spacer()
            content
        }
    }
}

struct ListLabel_Previews: PreviewProvider {
    static var previews: some View {
        ListLabelBlock(label: "List Label") {
            Text("Hi")
        }
    }
}
