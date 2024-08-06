//
//  CheckmarkBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/2/22.
//

import SwiftUI

public struct CheckmarkBlock: View {
    
    @Environment(\.isEnabled) private var isEnabled
    
    @Binding var checked: Bool
    @Binding var changed: Bool
    
    private var text: String
    private var independent: Bool
    private var eventTracker: UIEventTracker?
    
    public init(text: String, checked: Binding<Bool>, changed: Binding<Bool>, independent: Bool = true,  eventTracker: UIEventTracker? = nil) {
        self.text = text
        self._checked = checked
        self._changed = changed
        self.independent = independent
        self.eventTracker = eventTracker
    }
    
    public var body: some View {
        HStack {
            Image(systemName: checked ? "checkmark.square.fill" : "square")
                .foregroundColor(checked ? Color.accentColor : Color.secondary)
            Text(text)
                .font(.subheadline)
                .cornerRadius(5)
        }
        .if(independent, transform: { view in
            view
                .background(isEnabled ? .clear : Color(UIColor.systemGray3).opacity(0.5))
                .onTapGesture {
                    checked.toggle()
                    changed.toggle()
                    eventTracker?.logUIEvent(.checkmarkToggled, parameters: ["text": text, "checked": checked])
                }
        })
    }
}

struct CheckmarkBlock_Previews: PreviewProvider {
    static var previews: some View {
        CheckmarkBlock(text: "Sample Checkmark", checked: Binding.constant(false), changed: Binding.constant(false))
    }
}
