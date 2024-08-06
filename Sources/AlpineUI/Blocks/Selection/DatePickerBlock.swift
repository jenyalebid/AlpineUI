//
//  DatePickerBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/9/22.
//

import SwiftUI

public struct DatePickerBlock: View {

    @Environment(\.isEnabled) private var isEnabled
    
    @Binding var value: Date
    @Binding var changed: Bool
    
    private var title: String
    private var eventTracker: UIEventTracker?
    
    public init(title: String, value: Binding<Date>, changed: Binding<Bool>, eventTracker: UIEventTracker? = nil) {
        self.title = title
        self._value = value
        self._changed = changed
        self.eventTracker = eventTracker
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            if title != "" {
                Text("\(title):").font(.footnote)
            }
            DatePicker(selection: $value) {}
                .labelsHidden()
                .frame(width: 208)
                .transformEffect(.init(scaleX: 0.95, y: 0.95))

        }
    }
}

struct DatePickerBlock_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerBlock(title: "Date", value: Binding.constant(Date()), changed: .constant(false))
    }
}
