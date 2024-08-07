//
//  ListLabel.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/4/23.
//

import SwiftUI

public struct ListLabel: View {
    
    private var content: String
    
    public init(_ content: String) {
        self.content = content
    }
    
    public var body: some View {
        Text(content + ":")
            .font(.caption)
    }
}

struct ListLabelBlock_Previews: PreviewProvider {
    static var previews: some View {
        ListLabel("Title")
    }
}
