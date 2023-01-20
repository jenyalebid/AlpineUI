//
//  BoolCheckmarkBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 6/9/22.
//

import SwiftUI

public struct BoolCheckmarkBlock: View {
    
    var title1: String
    var title2: String
    var required: Bool
    
    var spacing: Double

    @Binding var bool: Bool
    @Binding var changed: Bool
    
    public init(title1: String, title2: String, bool: Binding<Bool>, spacing: Double = 20, required: Bool = false, changed: Binding<Bool>) {
        self.title1 = title1
        self.title2 = title2
        self._bool = bool
        self.spacing = spacing
        self.required = required
        self._changed = changed
        
    }
    
    public var body: some View {
        HStack {
            CheckmarkBlock(text: title1, checked: .constant(bool ? true : false), changed: .constant(false), independent: false)
                .onTapGesture {
                    bool = true
                }
            Divider()
                .padding(.horizontal, spacing)
                .frame(height: 30)
            CheckmarkBlock(text: title2, checked: .constant(bool ? false : true), changed: .constant(false), independent: false)
                .onTapGesture {
                    bool = false
                }
        }
        .onChange(of: bool) { _ in
            changed.toggle()
        }
    }
}

struct BoolCheckmarkBlock_Previews: PreviewProvider {
    static var previews: some View {
        BoolCheckmarkBlock(title1: "Yes", title2: "No", bool: .constant(true), changed: .constant(false))
    }
}
