//
//  ListLabel.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/4/23.
//

import SwiftUI

struct ListLabel: View {
    
    init(_ content: String) {
        self.content = content
    }
    
    var content: String
    
    var body: some View {
        Text(content + ":")
//            .fontWeight(.semibold)
            .font(.caption)
    }
}

struct ListLabelBlock_Previews: PreviewProvider {
    static var previews: some View {
        ListLabel("Title")
    }
}
