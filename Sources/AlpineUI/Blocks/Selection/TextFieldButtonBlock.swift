//
//  TextFieldButtonBlock.swift
//  
//
//  Created by Jenya Lebid on 3/24/23.
//

import SwiftUI

public struct TextFieldButtonBlock: View {

    var title: String
    var text: String
    
    public init(title: String, text: String, action: @escaping () -> ()) {
        self.title = title
        self.text = text
        self.action = action
    }
    
    var action: () -> ()
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("\(title):")
                .font(.footnote)
            Button {
                action()
            } label: {
                FieldFrameBlock(selection: .constant(text), fieldType: .text)
            }
        }
    }
}

struct TextFieldButtonBlock_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldButtonBlock(title: "Location", text: "-123.3232, 32.21331") {
            
        }
    }
}
