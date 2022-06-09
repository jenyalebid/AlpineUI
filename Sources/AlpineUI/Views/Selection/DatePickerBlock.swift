//
//  DatePickerBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/9/22.
//

import SwiftUI

public struct DatePickerBlock: View {

    @Environment(\.isEnabled) var isEnabled
    
    var title: String
    
    @Binding var value: Date
    @Binding var changed: Bool
    
    public init(title: String, value: Binding<Date>, changed: Binding<Bool>) {
        self.title = title
        self._value = value
        self._changed = changed
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("\(title):").font(.footnote)
            DatePicker(selection: $value) {}
                .labelsHidden()
                .transformEffect(.init(scaleX: 0.9, y: 0.9))
                .frame(width: 216)
        }
//        .onChange(of: value) { _ in
//            changed.toggle()
//        }
    }
}

struct DatePickerBlock_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerBlock(title: "Date", value: Binding.constant(Date()), changed: .constant(false))
    }
}
