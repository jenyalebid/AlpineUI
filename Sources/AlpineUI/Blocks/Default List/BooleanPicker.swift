//
//  BooleanPicker.swift
//  
//
//  Created by Vladislav on 8/7/24.
//

import SwiftUI

internal struct BooleanPicker: View {
    
    @Binding var value: NSNumber
    
    private var leftLabel: String
    private var rightLabel: String
    private var onEvent: ((AlpineUIEvent, [String: Any]?) -> Void)?
    
    public init(leftLabel: String, rightLabel: String, value: Binding<NSNumber>, onEvent: ((AlpineUIEvent, [String: Any]?) -> Void)? = nil) {
        self.leftLabel = leftLabel
        self.rightLabel = rightLabel
        self._value = value
        self.onEvent = onEvent
    }
    
    public var body: some View {
        HStack {
            BooleanBlock(label: leftLabel, checked: .constant(value == true ? true : false), onEvent: { event, parameters in
                onEvent?(event, parameters)
            })
                .simultaneousGesture(
                    TapGesture()
                        .onEnded {
                            value = true
                        }
                )
            Divider()
                .frame(height: 20)
                .padding(.horizontal)
            BooleanBlock(label: rightLabel, checked: .constant(value == false ? true : false), onEvent: { event, parameters in
                onEvent?(event, parameters)
            })
                .simultaneousGesture(
                    TapGesture()
                        .onEnded {
                            value = false
                        }
                )
        }
    }
}
