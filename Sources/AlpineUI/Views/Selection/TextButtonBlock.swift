//
//  TextButtonBlock.swift
//  
//
//  Created by Jenya Lebid on 9/7/22.
//

import SwiftUI

public struct TextButtonBlock: View {
    
    var image: String?
    var text: String?
    var height: CGFloat?
    var width: CGFloat?
    var foreground: Color
    var background: Color
    var font: Font
    
    var action: () -> ()
    
    public init(image: String? = nil, text: String? = nil, width: CGFloat? = nil, height: CGFloat? = nil, foreground: Color = .white, background: Color = .accentColor, font: Font = .body, action: @escaping () -> ()) {
        self.image = image
        self.text = text
        self.width = width
        self.height = height
        self.foreground = foreground
        self.background = background
        self.font = font
        self.action = action
    }
    
    public var body: some View {
        Button {
            action()
        } label: {
            HStack {
                if let image = image {
                    Image(systemName: image)
                }
                if let text = text {
                    Text(text)
                }
            }
            .font(font)
            .foregroundColor(foreground)
            .padding(10)
            .frame(width: width, height: height)
            .background(background)
            .cornerRadius(10)
        }
    }
}

struct TextButtonBlock_Previews: PreviewProvider {
    static var previews: some View {
        TextButtonBlock(image: "person", font: .footnote) {
            
        }
    }
}
