//
//  MultiSelectBlock.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 1/20/23.
//

import SwiftUI

public struct MultiSelectBlock: View {
    
    @Environment(\.isEnabled) var isEnabled
    
    @Binding var selections: String
    @Binding var changed: Bool
    
    @State private var showPopover = false
    
    @FocusState private var focused: Bool
    
    private var title: String
    private var values: [PickerOption]
    private var required: Bool
    private var onEvent: ((UIEvent, [String: Any]?) -> Void)?
    
    public init(title: String, values: [PickerOption], selections: Binding<String>, required: Bool = false, changed: Binding<Bool>, onEvent: ((UIEvent, [String: Any]?) -> Void)? = nil) {
        self.title = title
        self.values = values
        self._selections = selections
        self.required = required
        self._changed = changed
        self.onEvent = onEvent
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("\(title):")
                .font(.footnote)
            FieldFrameBlock(selection: $selections, fieldType: .text)
                .popover(isPresented: $showPopover) {
                    MultiSelectMenu(values: values, selections: $selections) { event, parameters in
                        onEvent?(event, parameters)
                    }
                }
        }
        .onChange(of: selections) { _ in
            changed.toggle()
        }
        .onTapGesture {
            showPopover.toggle()
            if showPopover {
                onEvent?(.popoverOpened, ["title": title])
            } else {
                onEvent?(.popoverClosed, ["title": title])
            }
        }
    }
}

struct MultiSelectBlock_Previews: PreviewProvider {
    static var previews: some View {
        MultiSelectBlock(title: "Title", values: [PickerOption(primaryText: "1"), PickerOption(primaryText: "2"), PickerOption(primaryText: "3")], selections: .constant("1, 2, 3"), changed: .constant(false))
    }
}
