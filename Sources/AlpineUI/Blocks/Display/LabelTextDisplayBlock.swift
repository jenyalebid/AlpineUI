//
//  LabelTextDisplayBlock.swift
//  AlpineConnect
//
//  Created by Jenya Lebid on 9/6/22.
//

import SwiftUI

public struct LabelTextDisplayBlock: View {
    
    var title: String
    var text: String
    
    var font: Font
    
    public init(title: String, text: String, font: Font = .footnote) {
        self.title = title
        self.text = text
        self.font = font
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title + ":")
                .font(.caption2)
                .fontWeight(.light)
                .underline(true, color: .accentColor)
                .padding(.bottom, 3)
            Text(text)
                .font(font)
        }
//        .frame(maxWidth: .infinity)
    }
}

struct LabelTextDisplayBlock_Previews: PreviewProvider {
    static var previews: some View {
        LabelTextDisplayBlock(title: "Title", text: "Hello")
    }
}
