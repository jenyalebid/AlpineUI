//
//  CheckmarkInfoBlock.swift
//  
//
//  Created by Jenya Lebid on 6/1/22.
//

import SwiftUI

public struct CheckmarkInfoBlock: View {
    
    var primaryText: String
    var secondaryText: String
    var independent: Bool
    
    @Binding var checked: Bool
    @Binding var changed: Bool
    
    public init(prmaryText: String, secondaryText: String, checked: Binding<Bool>, changed: Binding<Bool>, independent: Bool = true) {
        self.primaryText = prmaryText
        self.secondaryText = secondaryText
        self._checked = checked
        self._changed = changed
        self.independent = independent
    }
    
    public var body: some View {
        HStack {
            CheckmarkBlock(text: primaryText, checked: $checked, changed: $changed, independent: false)
                .padding(.trailing)
            Text(secondaryText)
                .font(.footnote)
                .foregroundColor(Color(uiColor: .systemGray))
        }
        .padding(6.0)
        .overlay (
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color(uiColor: .systemGray), lineWidth: (0.2))
        )
        .contentShape(Rectangle())
        .if(independent) { view in
            view
                .onTapGesture {
                    checked.toggle()
                    changed.toggle()
                }
        }
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CheckmarkInfoBlock(prmaryText: "Title", secondaryText: "Second Title", checked: .constant(true), changed: .constant(false))
    }
}
