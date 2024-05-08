//
//  MultiSelectMenu.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/3/22.
//

import SwiftUI

public struct MultiSelectMenu: View {
    
    @StateObject var viewModel: MultiSelectMenuViewModel
    
    @Binding var selections: String
    
    public init(values: [PickerOption], selections: Binding<String>) {
        self._selections = selections
        self._viewModel = StateObject(wrappedValue: MultiSelectMenuViewModel(selections: selections.wrappedValue, values: values))
    }
    
    public var body: some View {
        ScrollView {
            ForEach(viewModel.values) { value in
                VStack(spacing: 10) {
                    HStack {
                        Text(value.rawText ?? value.primaryText)
                        Spacer()
                        if viewModel.selectedValues.contains(value.primaryText) {
                            Image(systemName: "checkmark")
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selections = viewModel.addRemoveFromSelection(value.primaryText)
                    }
                    .padding(.horizontal, 10.0)
                    if viewModel.values.last != value {
                        Divider()
                    }
                }
            }
        }
        .padding(.vertical, 10)
        .frame(minWidth: 140)
    }
}

//struct MultiSelectMenu_Previews: PreviewProvider {
//    static var previews: some View {
//        MultiSelectMenu(values: ["1", "2", "3", "4"], exisingSelections: Binding.constant("2, 3"))
//    }
//}
