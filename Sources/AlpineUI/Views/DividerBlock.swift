//
//  DividerBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/27/22.
//

import SwiftUI

public struct DividerBlock: View {
    
    var label: String
    
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
