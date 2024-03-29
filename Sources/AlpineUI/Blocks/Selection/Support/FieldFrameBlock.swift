//
//  FieldFrameBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 1/20/23.
//

import SwiftUI

struct FieldFrameBlock: View {
    
    @Environment(\.isEnabled) var isEnabled
    
    enum FieldType {
        case text
        case TextField
    }
    
    var required: Bool
    var fieldType: FieldType
    
    @Binding var selection: String
    
    @FocusState private var focused: Bool
    
    init(selection: Binding<String>, required: Bool = false, fieldType: FieldType) {
        self._selection = selection
        self.required = required
        self.fieldType = fieldType
    }
    
    var body: some View {
        Group {
            switch fieldType {
            case .TextField:
                TextField("", text: $selection)
            case .text:
                Text(selection)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 20)
        .padding(6.0)
        .overlay (
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color((required && selection == "") ? UIColor.systemRed : UIColor.systemGray), lineWidth: (required && selection == "") ? 1.2 : 0.2)
        )
        .background(isEnabled ? Color(UIColor.systemBackground) : Color(UIColor.systemGray3).opacity(0.5))
        .cornerRadius(5)
        .focused($focused)
    }
}
