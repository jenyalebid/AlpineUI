//
//  ListTextFieldBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/4/23.
//

import SwiftUI

public struct ListTextFieldBlock: View {
    
    var title: String
    @Binding var content: String
    
    public init(title: String, content: Binding<String>) {
        self.title = title
        self._content = content
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            ListLabel(title)
            TextField(title, text: $content)
                .textFieldStyle(.roundedBorder)
        }
    }
}

struct ListTextFieldBlock_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ListTextFieldBlock(title: "Custom Name", content: .constant("Counties"))
        }
    }
}
