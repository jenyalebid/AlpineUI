//
//  DividerBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/27/22.
//

import SwiftUI

internal struct DividerBlock: View {
    
    private var label: String
    
    public init(label: String) {
        self.label = label
    }
    
    public var body: some View {
        HStack {
            LabelBlock(value: label)
            VStack {
                Divider()
                    .padding()
            }
        }
        .padding(.top)
    }
}

struct DividerBlock_Previews: PreviewProvider {
    static var previews: some View {
        DividerBlock(label: "Label")
    }
}
