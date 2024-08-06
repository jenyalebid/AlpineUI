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
    private var eventTracker: UIEventTracker?
    
    public init(title: String, values: [PickerOption], selections: Binding<String>, required: Bool = false, changed: Binding<Bool>, eventTracker: UIEventTracker? = nil) {
        self.title = title
        self.values = values
        self._selections = selections
        self.required = required
        self._changed = changed
        self.eventTracker = eventTracker
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("\(title):")
                .font(.footnote)
            FieldFrameBlock(selection: $selections, fieldType: .text)
                .popover(isPresented: $showPopover) {
                    MultiSelectMenu(values: values, selections: $selections, eventTracker: eventTracker)
                }
        }
        .onChange(of: selections) { _ in
            changed.toggle()
        }
        .onTapGesture {
            showPopover.toggle()
            if showPopover {
                eventTracker?.logUIEvent(.popoverOpened, parameters: ["title": title])
            } else {
                eventTracker?.logUIEvent(.popoverClosed, parameters: ["title": title])
            }
        }
    }
}

struct MultiSelectBlock_Previews: PreviewProvider {
    static var previews: some View {
        MultiSelectBlock(title: "Title", values: [PickerOption(primaryText: "1"), PickerOption(primaryText: "2"), PickerOption(primaryText: "3")], selections: .constant("1, 2, 3"), changed: .constant(false))
    }
}
