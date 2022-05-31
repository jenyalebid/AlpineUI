//
//  LabelBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/27/22.
//

import SwiftUI

public struct LabelBlock: View {
    
    var value: String
    
    public var body: some View {
        Text("\(value):").font(.footnote)
    }
}

struct LabelBlock_Previews: PreviewProvider {
    static var previews: some View {
        LabelBlock(value: "It's a label")
    }
}
