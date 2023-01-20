//
//  TextDisplayBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/2/22.
//

import SwiftUI

public struct TextDisplayBlock: View {
    
    var title: String
    var text: String
    var font: Font
    
    public init(title: String, text: String, font: Font = .body) {
        self.title = title
        self.text = text
        self.font = font
    }
    
    public var body: some View {
        HStack {
            Text("\(title):").font(.footnote)
            Text("\(text)")
                .font(font)
        }
//        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct TextDisplayBlock_Previews: PreviewProvider {
    static var previews: some View {
        TextDisplayBlock(title: "Text Title", text: "Sample Text")
    }
}
