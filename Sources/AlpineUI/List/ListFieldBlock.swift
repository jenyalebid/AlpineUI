//
//  ListFieldBlock.swift
//  
//
//  Created by Jenya Lebid on 5/12/23.
//

import SwiftUI

public struct ListFieldBlock: View {
    
    var label: String
    
    public init(_ label: String) {
        self.label = label
    }
        
    public var body: some View {
        Text(label)
            .fontWeight(.semibold)
            .font(.caption)
    }
}

struct ListFieldBlock_Previews: PreviewProvider {
    static var previews: some View {
        ListFieldBlock("Text")
    }
}
