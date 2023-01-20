//
//  MultiSelectBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 1/20/23.
//

import SwiftUI

public struct MultiSelectBlock: View {
    
    @Environment(\.isEnabled) var isEnabled
    
    var title: String
    var values: [PickerOption]
    var required: Bool
    
    @Binding var selections: String
    @Binding var changed: Bool
    
    @State var showPopover = false
    
    @FocusState private var focused: Bool
    
    public init(title: String, values: [PickerOption], selections: Binding<String>, required: Bool = false, changed: Binding<Bool>) {
        self.title = title
        self.values = values
        self._selections = selections
        self.required = required
        self._changed = changed
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("\(title):")
                .font(.footnote)
            FieldFrameBlock(title: title, selection: $selections, fieldType: .text)
                .popover(isPresented: $showPopover) {
                    MultiSelectMenu(values: values, selections: $selections)
                }
        }
        .onTapGesture {
            showPopover.toggle()
        }
        
    }
}

struct MultiSelectBlock_Previews: PreviewProvider {
    static var previews: some View {
        MultiSelectBlock(title: "Title", values: [PickerOption(primaryText: "1"), PickerOption(primaryText: "2"), PickerOption(primaryText: "3")], selections: .constant("1, 2, 3"), changed: .constant(false))
    }
}
