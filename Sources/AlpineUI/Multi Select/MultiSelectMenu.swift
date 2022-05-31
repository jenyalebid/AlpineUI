//
//  MultiSelectMenu.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 5/3/22.
//

import SwiftUI

public struct MultiSelectMenu: View {
    
    var values: [[String]]
    
    @Binding var exisingSelections: String
    @ObservedObject var viewModel: MultiSelectMenuViewModel
    
    public init(values: [[String]], exisingSelections: Binding<String>) {
        self.values = values
        self._exisingSelections = exisingSelections
        
        viewModel = MultiSelectMenuViewModel(existingSelections: exisingSelections.wrappedValue)
    }
    
    public var body: some View {
        VStack {
            ForEach(values, id: \.self) { value in
                VStack(spacing: 10) {
                    HStack {
                        Text("\(value.count > 1 ? value[1] : value[0])")
                        Spacer()
                        if viewModel.selectedValues.contains(value[0]) {
                            Image(systemName: "checkmark")
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        exisingSelections = viewModel.addRemoveFromSelection(value[0])
                    }
                    .padding(.horizontal, 10.0)
                    if values.last != value {
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
