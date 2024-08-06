//
//  ToolBarImage.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/5/22.
//

import SwiftUI

public struct ToolBarImage: View {
    
    @Binding var currentTag: Int
    
    private var image: String
    private var tag: Int
    private var size = 10
    private var font = Font.title2
    
    public init(image: String, tag: Int, currentTag: Binding<Int>) {
        self.image = image
        self.tag = tag
        self._currentTag = currentTag
    }
    
    public var body: some View {
        Image(systemName: "\(image)")
            .font(font)
            .frame(width: CGFloat(size), height: CGFloat(size), alignment: .center)
            .foregroundColor(tag == currentTag ? Color.accentColor : Color(UIColor.systemGray))
            .padding()
    }
}

struct ToolBarImage_Previews: PreviewProvider {
    static var previews: some View {
        ToolBarImage(image: "leaf", tag: 1, currentTag: Binding.constant(1))
    }
}
