//
//  SectionBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 10/31/22.
//

import SwiftUI

public struct SectionBlock<Content: View>: View {
    
    var title: String
    var content: () -> Content
    
    public init(_ title: String, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }
    
    public var body: some View {
        LazyVStack(spacing: 0) {
            Text(title)
                .font(.callout)
                .foregroundColor(Color(uiColor: .systemGray))
                .fontWeight(.semibold)
                .padding(.top, 10)
                .padding(.bottom, 4)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
            content()
        }
    }
}

struct SectionBlock_Previews: PreviewProvider {
    static var previews: some View {
        SectionBlock("Hello") {
            
        }
    }
}
