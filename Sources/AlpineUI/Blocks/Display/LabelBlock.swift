//
//  LabelBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/27/22.
//

import SwiftUI

public struct LabelBlock: View {
    
    private var value: String
    
    public init(value: String) {
        self.value = value
    }
    
    public var body: some View {
        Text("\(value):").font(.footnote)
    }
}

struct LabelBlock_Previews: PreviewProvider {
    static var previews: some View {
        LabelBlock(value: "It's a label")
    }
}
