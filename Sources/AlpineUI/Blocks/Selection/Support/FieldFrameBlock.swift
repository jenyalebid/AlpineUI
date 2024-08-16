//
//  FieldFrameBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 1/20/23.
//

import SwiftUI

internal struct FieldFrameBlock: View {
    
    enum FieldType {
        case text
        case TextField
    }
    
    @Environment(\.isEnabled) private var isEnabled
    
    @FocusState private var focused: Bool
    
    @Binding var selection: String
    
    private var required: Bool
    private var fieldType: FieldType
    private var onEvent: ((AlpineUIEvent, [String: Any]?) -> Void)?
    
    init(selection: Binding<String>, required: Bool = false, fieldType: FieldType, onEvent: ((AlpineUIEvent, [String: Any]?) -> Void)? = nil) {
        self._selection = selection
        self.required = required
        self.fieldType = fieldType
        self.onEvent = onEvent
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
