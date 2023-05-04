//
//  ListTextBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/4/23.
//

import SwiftUI

public struct ListTextBlock: View {
    
    public init(title: String, content: String) {
        self.title = title
        self.content = content
    }
    
    
    var title: String
    var content: String
    
    public var body: some View {
        HStack {
            ListLabel(title)
            Spacer()
            Text(content)
        }
    }
}

struct ListTextBlock_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ListTextBlock(title: "Name", content: "county.shp")
        }
    }
}
