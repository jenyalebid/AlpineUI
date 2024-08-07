//
//  BooleanBlock.swift
//  
//
//  Created by Vladislav on 8/7/24.
//

import SwiftUI

internal struct BooleanBlock: View {
    
    @Binding var checked: Bool
    
    private var label: String
    private var eventTracker: UIEventTracker?
    
    public init(label: String, checked: Binding<Bool>, eventTracker: UIEventTracker? = nil ) {
        self.label = label
        self._checked = checked
        self.eventTracker = eventTracker
    }
    
    public var body: some View {
        HStack {
            Image(systemName: checked ? "checkmark.square.fill" : "square")
                .foregroundColor(checked ? Color.accentColor : Color.secondary)
            Text(label)
        }
        .contentShape(RoundedRectangle(cornerRadius: 5))
        .onTapGesture {
            checked.toggle()
            eventTracker?.logUIEvent(.booleanPickerChanged, parameters: ["label": label])
        }
    }
}
