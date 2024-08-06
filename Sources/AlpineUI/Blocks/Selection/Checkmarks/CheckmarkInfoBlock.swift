//
//  CheckmarkInfoBlock.swift
//  
//
//  Created by Jenya Lebid on 6/1/22.
//

import SwiftUI

internal struct CheckmarkInfoBlock: View {
    
    @Environment(\.isEnabled) private var isEnabled
    
    @Binding var checked: Bool
    @Binding var changed: Bool
    
    private var primaryText: String
    private var secondaryText: String
    private var independent: Bool
    private var width: CGFloat?
    private var eventTracker: UIEventTracker?
    
    public init(prmaryText: String, secondaryText: String, checked: Binding<Bool>, changed: Binding<Bool>, independent: Bool = true, width: CGFloat? = nil, eventTracker: UIEventTracker? = nil) {
        self.primaryText = prmaryText
        self.secondaryText = secondaryText
        self._checked = checked
        self._changed = changed
        self.independent = independent
        self.width = width
        self.eventTracker = eventTracker
    }
    
    public var body: some View {
        HStack {
            CheckmarkBlock(text: primaryText, checked: $checked, changed: $changed, independent: false, eventTracker: eventTracker)
                .padding(.trailing)
            if width != nil {
                Spacer()
            }
            Text(secondaryText)
                .font(.footnote)
                .foregroundColor(Color(uiColor: .systemGray))
                .frame(alignment: .trailing)
        }
        .padding(6.0)
        .background(isEnabled ? Color(uiColor: .systemBackground) : Color(uiColor: .systemGray3).opacity(0.5))
        .cornerRadius(5)
        .if(width != nil) { view in
            view
                .frame(width: width!, alignment: .leading)
        }
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

struct CheckmarkInfoBlock_Previews: PreviewProvider {
    static var previews: some View {
        CheckmarkInfoBlock(prmaryText: "Title", secondaryText: "Second Title", checked: .constant(true), changed: .constant(false))
    }
}
