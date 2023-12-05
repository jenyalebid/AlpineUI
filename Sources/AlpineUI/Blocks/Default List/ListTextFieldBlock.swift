//
//  ListTextFieldBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/4/23.
//

import SwiftUI
import JSwiftUI

public struct ListTextFieldBlock: View {
    
    var title: String
    var placeHolder: String?
    @Binding var content: String
    
    var required: Bool
        
    public init(title: String, placeHolder: String? = nil, content: Binding<String>, required: Bool = false) {
        self.title = title
        self.placeHolder = placeHolder
        self._content = content
        
        self.required = required
    }
    
    public init(placeHolder: String? = nil, content: Binding<String>) {
        self.placeHolder = placeHolder
        self._content = content
        self.title = ""
        required = false
    }

    public var body: some View {
        if title.isEmpty {
            textField
        }
        else {
            labelTextField
        }
    }
    
    var labelTextField: some View {
        VStack(alignment: .leading, spacing: 3) {
            ListLabel(title)
            textField
        }
    }
    
    var textField: some View {
        TextField(placeHolder ?? title, text: $content)
            .requiredOutline(required && content.isEmpty)
            .textFieldStyle(.roundedBorder)
    }
}

public struct ListIconTextFieldBlock: View {
    
    var systemImage: String
    var title: String
    
    public init(systemImage: String, title: String) {
        self.systemImage = systemImage
        self.title = title
    }
    
    public var body: some View {
        HStack {
            Image(systemName: systemImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20, alignment: .center)
                .padding(.trailing, 4)
            Text(title)
        }
    }
}

struct ListTextFieldBlock_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ListTextFieldBlock(title: "Custom Name", content: .constant("Counties"))
        }
    }
}
