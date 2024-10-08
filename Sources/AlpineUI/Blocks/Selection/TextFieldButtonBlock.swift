//
//  TextFieldButtonBlock.swift
//  
//
//  Created by Jenya Lebid on 3/24/23.
//

import SwiftUI

public struct TextFieldButtonBlock: View {

    private var title: String
    private var text: String
    private var action: () -> ()
    private var onEvent: ((AlpineUIEvent, [String: Any]?) -> Void)?
    
    public init(title: String, text: String, onEvent: ((AlpineUIEvent, [String: Any]?) -> Void)? = nil, action: @escaping () -> ()) {
        self.title = title
        self.text = text
        self.action = action
        self.onEvent = onEvent
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("\(title):")
                .font(.footnote)
            Button {
                action()
                onEvent?(.textFieldButton, ["titleTextFieldButton" : "\(title)", "textTextFieldButton" : "\(text)"])
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
